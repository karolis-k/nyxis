import 'package:flutter/material.dart';

import '../../config/item_config.dart';
import '../../config/monster_config.dart';
import '../../game/systems/turn_system.dart';
import '../../models/entities/entity.dart';
import '../../models/entities/item.dart';
import '../../models/entities/monster.dart';
import '../../models/game_state.dart';

/// Callback type for player actions.
typedef ActionCallback = void Function(PlayerAction action);

/// A toolbar displaying available player actions based on context.
///
/// Shows buttons for:
/// - Wait (skip turn) - always available
/// - Pickup (when items at player position)
/// - Attack (when adjacent to monsters)
/// - Inventory (always available)
class ActionToolbar extends StatelessWidget {
  final GameState gameState;
  final ActionCallback onAction;
  final VoidCallback onInventory;

  const ActionToolbar({
    super.key,
    required this.gameState,
    required this.onAction,
    required this.onInventory,
  });

  @override
  Widget build(BuildContext context) {
    if (!gameState.isPlaying) {
      return const SizedBox.shrink();
    }

    final availableActions = _getAvailableActions();

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade700),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Inventory button (always available)
            _ActionButton(
              icon: Icons.backpack,
              label: 'Inventory',
              onTap: onInventory,
              color: Colors.amber,
            ),

            // Divider
            if (availableActions.isNotEmpty) ...[
              const SizedBox(width: 4),
              Container(
                width: 1,
                height: 32,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
            ],

            // Context-sensitive actions
            ...availableActions,

            // Wait button (always available)
            const SizedBox(width: 4),
            Container(
              width: 1,
              height: 32,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            _ActionButton(
              icon: Icons.hourglass_empty,
              label: 'Wait',
              onTap: () => onAction(PlayerWaitAction()),
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  /// Gets the list of available context-sensitive action widgets.
  List<Widget> _getAvailableActions() {
    final actions = <Widget>[];
    final playerPos = gameState.player.position;

    // Check for items at player position
    final itemsHere = _getItemsAtPosition(playerPos);
    for (final item in itemsHere) {
      final config = ItemRegistry.tryGet(item.configId);
      final itemName = config?.name ?? 'Item';
      final itemIcon = _getItemIcon(config?.type);

      actions.add(_ActionButton(
        icon: itemIcon,
        label: 'Pickup $itemName',
        onTap: () => onAction(PlayerPickupAction(item.id)),
        color: _getItemColor(config?.type),
      ));
    }

    // Check for adjacent monsters
    final adjacentMonsters = _getAdjacentMonsters(playerPos);
    for (final monster in adjacentMonsters) {
      final config = MonsterRegistry.tryGet(monster.configId);
      final monsterName = config?.name ?? 'Enemy';

      actions.add(_ActionButton(
        icon: Icons.gps_fixed,
        label: 'Attack $monsterName',
        onTap: () => onAction(PlayerAttackAction(monster.id)),
        color: Colors.red,
      ));
    }

    return actions;
  }

  /// Gets items at a specific position.
  List<Item> _getItemsAtPosition(Position pos) {
    return gameState.items.values
        .where((item) => item.isInWorld && item.position == pos)
        .toList();
  }

  /// Gets alive monsters adjacent to a position.
  List<Monster> _getAdjacentMonsters(Position pos) {
    return gameState.monsters.values.where((monster) {
      if (!monster.isAlive) return false;

      // Check if adjacent (within 1 tile manhattan distance)
      final dx = (monster.position.x - pos.x).abs();
      final dy = (monster.position.y - pos.y).abs();
      return dx + dy == 1;
    }).toList();
  }

  /// Gets the icon for an item type.
  IconData _getItemIcon(ItemType? type) {
    return switch (type) {
      ItemType.weapon => Icons.gavel,
      ItemType.armor => Icons.shield,
      ItemType.consumable => Icons.local_drink,
      ItemType.key => Icons.key,
      ItemType.treasure => Icons.diamond,
      null => Icons.category,
    };
  }

  /// Gets the color for an item type.
  Color _getItemColor(ItemType? type) {
    return switch (type) {
      ItemType.weapon => Colors.orange,
      ItemType.armor => Colors.blue,
      ItemType.consumable => Colors.green,
      ItemType.key => Colors.yellow,
      ItemType.treasure => Colors.purple,
      null => Colors.grey,
    };
  }
}

/// A single action button in the toolbar.
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
