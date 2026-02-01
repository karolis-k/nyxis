import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

/// Audio service for managing sound effects and background music.
///
/// Uses the singleton pattern for global access throughout the game.
/// All audio files should be placed in assets/audio/ folder.
class AudioService {
  static final AudioService _instance = AudioService._();
  static AudioService get instance => _instance;

  AudioService._();

  /// Current master volume (0.0 to 1.0)
  double _volume = 1.0;

  /// Whether audio is muted
  bool _isMuted = false;

  /// Whether the service has been initialized
  bool _isInitialized = false;

  /// Currently playing background music track ID
  String? _currentMusicId;

  /// Common sound effects to preload for better performance
  static const List<String> _commonSounds = [
    'bow_release.mp3',
    'monster_attack.mp3',
    'monster_ranged_attack.mp3',
    'potion_drink.mp3',
    'sword_impact.mp3',
  ];

  /// Initialize and preload common sounds for better performance.
  ///
  /// Should be called once during app startup, typically in main() or
  /// during the loading screen.
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      // Preload common sound effects into cache
      for (final sound in _commonSounds) {
        try {
          await FlameAudio.audioCache.load(sound);
        } catch (e) {
          // Log but don't fail if a specific sound doesn't exist
          debugPrint('AudioService: Failed to preload $sound: $e');
        }
      }

      // Preload background music
      try {
        await FlameAudio.audioCache.load('background_music.mp3');
      } catch (e) {
        debugPrint('AudioService: Failed to preload background music: $e');
      }

      _isInitialized = true;
      debugPrint('AudioService: Initialized successfully');
    } catch (e) {
      debugPrint('AudioService: Initialization error: $e');
      // Mark as initialized anyway to prevent repeated attempts
      _isInitialized = true;
    }
  }

  /// Play a one-shot sound effect.
  ///
  /// [soundId] - The filename of the sound (e.g., 'sword_impact.mp3')
  ///
  /// The sound will play at the current volume level unless muted.
  /// If the audio file doesn't exist, the error is caught and logged.
  void playSound(String soundId) {
    if (_isMuted) return;

    try {
      FlameAudio.play(soundId, volume: _volume);
    } catch (e) {
      debugPrint('AudioService: Failed to play sound $soundId: $e');
    }
  }

  /// Play background music in a loop.
  ///
  /// [musicId] - The filename of the music (e.g., 'background_music.mp3')
  ///
  /// If music is already playing, it will be stopped before starting
  /// the new track. The music loops automatically.
  Future<void> playMusic(String musicId) async {
    if (_isMuted) {
      // Store the music ID so it can be played when unmuted
      _currentMusicId = musicId;
      return;
    }

    try {
      // Stop any currently playing music
      if (_currentMusicId != null) {
        await FlameAudio.bgm.stop();
      }

      _currentMusicId = musicId;
      await FlameAudio.bgm.play(musicId, volume: _volume);
    } catch (e) {
      debugPrint('AudioService: Failed to play music $musicId: $e');
    }
  }

  /// Stop the current background music.
  void stopMusic() {
    try {
      FlameAudio.bgm.stop();
      _currentMusicId = null;
    } catch (e) {
      debugPrint('AudioService: Failed to stop music: $e');
    }
  }

  /// Pause the current background music.
  void pauseMusic() {
    try {
      FlameAudio.bgm.pause();
    } catch (e) {
      debugPrint('AudioService: Failed to pause music: $e');
    }
  }

  /// Resume the paused background music.
  void resumeMusic() {
    if (_isMuted) return;

    try {
      FlameAudio.bgm.resume();
    } catch (e) {
      debugPrint('AudioService: Failed to resume music: $e');
    }
  }

  /// Set the master volume for all audio.
  ///
  /// [volume] - A value between 0.0 (silent) and 1.0 (full volume)
  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);

    // Update background music volume if playing
    if (_currentMusicId != null && !_isMuted) {
      try {
        FlameAudio.bgm.audioPlayer.setVolume(_volume);
      } catch (e) {
        debugPrint('AudioService: Failed to set BGM volume: $e');
      }
    }
  }

  /// Get the current master volume.
  double get volume => _volume;

  /// Mute or unmute all audio.
  ///
  /// [muted] - If true, all audio will be silenced. If false, audio resumes.
  void setMuted(bool muted) {
    final wasMuted = _isMuted;
    _isMuted = muted;

    if (muted) {
      // Pause background music when muting
      try {
        FlameAudio.bgm.pause();
      } catch (e) {
        debugPrint('AudioService: Failed to pause BGM on mute: $e');
      }
    } else if (wasMuted && _currentMusicId != null) {
      // Resume background music when unmuting
      try {
        FlameAudio.bgm.resume();
      } catch (e) {
        // If resume fails, try playing from scratch
        playMusic(_currentMusicId!);
      }
    }
  }

  /// Check if audio is currently muted.
  bool get isMuted => _isMuted;

  /// Check if the service has been initialized.
  bool get isInitialized => _isInitialized;

  /// Dispose of audio resources.
  ///
  /// Should be called when the app is closing.
  void dispose() {
    try {
      FlameAudio.bgm.stop();
      FlameAudio.bgm.dispose();
      FlameAudio.audioCache.clearAll();
    } catch (e) {
      debugPrint('AudioService: Error during dispose: $e');
    }
    _isInitialized = false;
    _currentMusicId = null;
  }
}
