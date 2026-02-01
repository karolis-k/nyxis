import 'package:flutter/material.dart';

import '../../config/item_config.dart';
import '../../game/my_game.dart';

/// Heads-up display showing player status and game info.
class HudWidget extends StatefulWidget {
  final MyGame game;

  const HudWidget({super.key, required this.game});

  @override
  State<HudWidget> createState() => _HudWidgetState();
}

class _HudWidgetState extends State<HudWidget> {
  int _currentFloor = 1;

  @override
  void initState() {
    super.initState();
    // Safe access to current floor (returns 1 if game not ready)
    _currentFloor = widget.game.currentFloor;

    // Listen for floor changes
    widget.game.onFloorChanged = (floor) {
      if (mounted) {
        setState(() {
          _currentFloor = floor;
        });
      }
    };
  }

  @override
  void dispose() {
    widget.game.onFloorChanged = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Health and Floor
            Row(
              children: [
                // Health bar
                Expanded(
                  child: _buildHealthBar(),
                ),
                const SizedBox(width: 16),
                // Floor indicator
                _buildFloorIndicator(),
              ],
            ),
            const SizedBox(height: 8),
            // Equipment row
            Row(
              children: [
                _buildEquipmentSlot('weapon'),
                const SizedBox(width: 8),
                _buildEquipmentSlot('armor'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthBar() {
    final gameState = widget.game.gameStateOrNull;
    if (gameState == null) {
      // Game not ready yet - show placeholder
      return Container(
        height: 24,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade700),
        ),
      );
    }

    final player = gameState.player;
    final healthPercent = player.health / player.maxHealth;
    final healthColor = _getHealthColor(healthPercent);

    return Container(
      height: 24,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Stack(
          children: [
            // Background
            Container(color: Colors.black38),
            // Health fill
            FractionallySizedBox(
              widthFactor: healthPercent.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [healthColor, healthColor.withValues(alpha: 0.7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Health text
            Center(
              child: Text(
                '${player.health} / ${player.maxHealth}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getHealthColor(double percent) {
    if (percent > 0.6) return Colors.green;
    if (percent > 0.3) return Colors.orange;
    return Colors.red;
  }

  Widget _buildFloorIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.stairs,
            color: Colors.grey,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            'Floor $_currentFloor',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentSlot(String slotType) {
    final gameState = widget.game.gameStateOrNull;
    if (gameState == null) return const SizedBox.shrink();

    final player = gameState.player;
    final itemId =
        slotType == 'weapon' ? player.equippedWeaponId : player.equippedArmorId;

    ItemConfig? config;
    if (itemId != null) {
      final item = gameState.items[itemId];
      if (item != null) {
        config = ItemRegistry.tryGet(item.configId);
      }
    }

    final IconData icon = slotType == 'weapon' ? Icons.gavel : Icons.shield;
    final Color bgColor =
        config != null ? _getItemColor(config.type) : Colors.grey.shade800;
    final Color borderColor =
        config != null ? _getRarityColor(config.rarity) : Colors.grey.shade600;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Color _getItemColor(ItemType type) {
    switch (type) {
      case ItemType.weapon:
        return Colors.red.shade700;
      case ItemType.armor:
        return Colors.blue.shade700;
      case ItemType.consumable:
        return Colors.green.shade700;
      case ItemType.key:
        return Colors.yellow.shade700;
      case ItemType.treasure:
        return Colors.amber.shade700;
    }
  }

  Color _getRarityColor(ItemRarity rarity) {
    switch (rarity) {
      case ItemRarity.common:
        return Colors.grey;
      case ItemRarity.uncommon:
        return Colors.green;
      case ItemRarity.rare:
        return Colors.blue;
      case ItemRarity.epic:
        return Colors.purple;
      case ItemRarity.legendary:
        return Colors.orange;
    }
  }
}
