import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../game/my_game.dart';
import '../../game/systems/turn_system.dart';
import '../../models/game_state.dart';
import '../widgets/action_toolbar.dart';
import '../widgets/hud_widget.dart';
import 'inventory_screen.dart';

/// Main game screen that hosts the Flame game widget.
class GameScreen extends StatefulWidget {
  /// The ID of the location being explored (e.g., 'village', 'dungeon_1')
  final String locationId;

  /// Callback to exit back to the world map
  final VoidCallback? onExitToWorldMap;

  const GameScreen({
    super.key,
    required this.locationId,
    this.onExitToWorldMap,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with WidgetsBindingObserver {
  late final MyGame _game;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _game = MyGame(
      locationId: widget.locationId,
      onExitToWorldMap: widget.onExitToWorldMap,
    );
    _game.onStateChanged = () {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Save game before disposing
    if (_game.isReady && _game.gameState.status == GameStatus.playing) {
      _game.saveGame();
    }
    _game.onStateChanged = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Save when app goes to background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      if (_game.isReady && _game.gameState.status == GameStatus.playing) {
        _game.saveGame();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Game widget
          GameWidget(
            game: _game,
            loadingBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorBuilder: (context, error) => Center(
              child: Text(
                'Error loading game:\n$error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            overlayBuilderMap: {
              'gameOver': (context, game) => _buildGameOverOverlay(context),
              'inventory': (context, game) => InventoryScreen(
                    gameState: _game.gameState,
                    onAction: (action) {
                      _game.processPlayerAction(action);
                      setState(() {}); // Refresh UI after action
                    },
                    onClose: () {
                      _game.overlays.remove('inventory');
                    },
                  ),
            },
          ),
          // HUD overlay (top)
          IgnorePointer(
            child: HudWidget(game: _game),
          ),
          // Action toolbar (bottom) - only show when game is ready
          if (_game.isReady)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: ActionToolbar(
                  gameState: _game.gameState,
                  onAction: _handleAction,
                  onInventory: _openInventory,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handleAction(PlayerAction action) {
    _game.processPlayerAction(action);
    setState(() {}); // Refresh UI to update toolbar
  }

  void _openInventory() {
    _game.overlays.add('inventory');
  }

  Widget _buildGameOverOverlay(BuildContext context) {
    final gameState = _game.gameState;
    final isVictory = gameState.status == GameStatus.victory;
    final player = gameState.player;

    return Container(
      color: Colors.black87,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isVictory ? Colors.amber : Colors.red.shade700,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                isVictory ? 'VICTORY!' : 'GAME OVER',
                style: TextStyle(
                  color: isVictory ? Colors.amber : Colors.red,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isVictory
                    ? 'You escaped the dungeon!'
                    : 'You have been slain...',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              // Stats section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildStatRow(Icons.stairs, 'Floor Reached', '${gameState.currentFloor}'),
                    const SizedBox(height: 8),
                    _buildStatRow(Icons.hourglass_empty, 'Turns Taken', '${gameState.turnNumber}'),
                    const SizedBox(height: 8),
                    _buildStatRow(Icons.star, 'Score', '${player.score}'),
                    const SizedBox(height: 8),
                    _buildStatRow(Icons.backpack, 'Items Collected', '${player.inventoryItemIds.length}'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _game.restart();
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Play Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 8),
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
