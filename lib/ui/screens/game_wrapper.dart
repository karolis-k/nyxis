import 'package:flutter/material.dart';

import '../../models/world/world_map.dart';
import '../../services/world_map_generator.dart';
import 'game_screen.dart';
import 'world_map_screen.dart';

/// Root game wrapper that manages transitions between world map and dungeon gameplay.
class GameWrapper extends StatefulWidget {
  const GameWrapper({super.key});

  @override
  State<GameWrapper> createState() => _GameWrapperState();
}

class _GameWrapperState extends State<GameWrapper> {
  /// Whether we're currently on the world map (vs in a location)
  bool _isOnWorldMap = false;

  /// The current world map state (lazy-initialized on first exit)
  WorldMap? _worldMap;

  /// The current location being explored (starts in dungeon)
  String? _currentLocationId = 'dark_dungeon';

  /// Key for forcing GameScreen rebuild when entering new locations
  UniqueKey _gameScreenKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    // World map is lazy-generated on first exit to world map
  }

  void _enterLocation(String locationId) {
    setState(() {
      _isOnWorldMap = false;
      _currentLocationId = locationId;
      _gameScreenKey = UniqueKey(); // Force new game instance
    });
  }

  void _exitToWorldMap() {
    setState(() {
      // Lazy-generate world map on first exit
      _worldMap ??= WorldMapGenerator.generate();
      _isOnWorldMap = true;
      _currentLocationId = null;
    });
  }

  void _onWorldMapChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_isOnWorldMap && _worldMap != null) {
      return Scaffold(
        body: Stack(
          children: [
            WorldMapScreen(
              worldMap: _worldMap!,
              onEnterLocation: _enterLocation,
              onStateChanged: _onWorldMapChanged,
            ),
            // World map HUD
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.map, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'World Map',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Instructions
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Use WASD or Arrow Keys to move • Press ENTER or SPACE to enter locations',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return GameScreen(
        key: _gameScreenKey,
        locationId: _currentLocationId!,
        onExitToWorldMap: _exitToWorldMap,
      );
    }
  }
}
