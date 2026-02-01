import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../models/game_state.dart';
import '../models/world/location.dart';

/// Service for persisting game data using Hive.
///
/// Uses separate boxes for different data types:
/// - 'saves': Game state snapshots keyed by slot ID
/// - 'locations': Per-location data keyed by location ID
///
/// This allows efficient per-location loading without loading
/// the entire world into memory.
class SaveService {
  SaveService._();

  static final SaveService _instance = SaveService._();
  static SaveService get instance => _instance;

  /// Box name for game save slots
  static const String _savesBoxName = 'saves';

  /// Box name for per-location persistence
  static const String _locationsBoxName = 'locations';

  /// Hive box for game saves
  late Box<String> _savesBox;

  /// Hive box for location data
  late Box<String> _locationsBox;

  /// Whether the service has been initialized
  bool _initialized = false;

  /// Initialize Hive and open boxes.
  ///
  /// Must be called before any other methods.
  /// Safe to call multiple times - subsequent calls are no-ops.
  Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    // Open boxes for storing serialized JSON strings
    _savesBox = await Hive.openBox<String>(_savesBoxName);
    _locationsBox = await Hive.openBox<String>(_locationsBoxName);

    _initialized = true;
  }

  /// Ensures the service is initialized before use.
  void _ensureInitialized() {
    if (!_initialized) {
      throw StateError(
        'SaveService not initialized. Call init() before using other methods.',
      );
    }
  }

  /// Save the current game state to a slot.
  ///
  /// The entire [state] is serialized to JSON and stored.
  /// Overwrites any existing save in the same [slotId].
  Future<void> saveGame(GameState state, String slotId) async {
    _ensureInitialized();

    final json = state.toJson();
    final jsonString = jsonEncode(json);
    await _savesBox.put(slotId, jsonString);
  }

  /// Load a game state from a slot.
  ///
  /// Returns `null` if no save exists for the given [slotId].
  Future<GameState?> loadGame(String slotId) async {
    _ensureInitialized();

    final jsonString = _savesBox.get(slotId);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return GameState.fromJson(json);
    } catch (e) {
      // Handle corrupted save data gracefully
      return null;
    }
  }

  /// Save a specific location for per-location persistence.
  ///
  /// Uses the location's [Location.id] as the storage key.
  /// This enables loading individual locations on-demand rather
  /// than the entire world at once.
  Future<void> saveLocation(Location location) async {
    _ensureInitialized();

    final json = location.toJson();
    final jsonString = jsonEncode(json);
    await _locationsBox.put(location.id, jsonString);
  }

  /// Load a specific location by ID.
  ///
  /// Returns `null` if no location exists for the given [locationId].
  Future<Location?> loadLocation(String locationId) async {
    _ensureInitialized();

    final jsonString = _locationsBox.get(locationId);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return Location.fromJson(json);
    } catch (e) {
      // Handle corrupted location data gracefully
      return null;
    }
  }

  /// Delete a save slot.
  ///
  /// Does nothing if the slot doesn't exist.
  Future<void> deleteSave(String slotId) async {
    _ensureInitialized();

    await _savesBox.delete(slotId);
  }

  /// Delete a saved location.
  ///
  /// Does nothing if the location doesn't exist.
  Future<void> deleteLocation(String locationId) async {
    _ensureInitialized();

    await _locationsBox.delete(locationId);
  }

  /// List all save slot IDs.
  ///
  /// Returns an empty list if no saves exist.
  Future<List<String>> listSaves() async {
    _ensureInitialized();

    return _savesBox.keys.cast<String>().toList();
  }

  /// List all saved location IDs.
  ///
  /// Returns an empty list if no locations are saved.
  Future<List<String>> listLocations() async {
    _ensureInitialized();

    return _locationsBox.keys.cast<String>().toList();
  }

  /// Check if a save exists for the given slot.
  Future<bool> saveExists(String slotId) async {
    _ensureInitialized();

    return _savesBox.containsKey(slotId);
  }

  /// Check if a location exists in storage.
  Future<bool> locationExists(String locationId) async {
    _ensureInitialized();

    return _locationsBox.containsKey(locationId);
  }

  /// Clear all saves (useful for testing or reset).
  Future<void> clearAllSaves() async {
    _ensureInitialized();

    await _savesBox.clear();
  }

  /// Clear all saved locations (useful for testing or reset).
  Future<void> clearAllLocations() async {
    _ensureInitialized();

    await _locationsBox.clear();
  }

  /// Clear all persisted data (saves and locations).
  Future<void> clearAll() async {
    _ensureInitialized();

    await Future.wait([
      _savesBox.clear(),
      _locationsBox.clear(),
    ]);
  }

  /// Close all Hive boxes.
  ///
  /// Should be called when the app is shutting down.
  Future<void> close() async {
    if (!_initialized) return;

    await Future.wait([
      _savesBox.close(),
      _locationsBox.close(),
    ]);
    _initialized = false;
  }
}
