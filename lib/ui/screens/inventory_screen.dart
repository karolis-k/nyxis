import 'package:flutter/material.dart';

import '../../config/item_config.dart';
import '../../game/systems/turn_system.dart';
import '../../models/entities/item.dart';
import '../../models/game_state.dart';

/// Inventory screen for managing player items.
class InventoryScreen extends StatelessWidget {
  final GameState gameState;
  final void Function(PlayerAction) onAction;
  final VoidCallback onClose;

  const InventoryScreen({
    super.key,
    required this.gameState,
    required this.onAction,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: SafeArea(
        child: Center(
          child: Container(
            width: 340,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade700, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const Divider(color: Colors.grey, height: 1),
                _buildEquipmentSection(),
                const Divider(color: Colors.grey, height: 1),
                Flexible(child: _buildInventoryList(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Inventory',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, color: Colors.white),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentSection() {
    final player = gameState.player;
    
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: _buildEquipmentSlot(
              label: 'Weapon',
              itemId: player.equippedWeaponId,
              slot: EquipmentSlot.weapon,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildEquipmentSlot(
              label: 'Armor',
              itemId: player.equippedArmorId,
              slot: EquipmentSlot.armor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentSlot({
    required String label,
    required String? itemId,
    required EquipmentSlot slot,
  }) {
    final item = itemId != null ? gameState.items[itemId] : null;
    final config = item != null ? ItemRegistry.tryGet(item.configId) : null;

    return GestureDetector(
      onTap: itemId != null ? () => onAction(PlayerUnequipAction(slot)) : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: itemId != null ? Colors.amber : Colors.grey.shade600,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            if (config != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildItemIcon(config),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      config.name,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            else
              Text(
                'Empty',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryList(BuildContext context) {
    final player = gameState.player;
    final inventoryItems = player.inventoryItemIds
        .map((id) => gameState.items[id])
        .whereType<Item>()
        .toList();

    if (inventoryItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Your inventory is empty',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: inventoryItems.length,
      itemBuilder: (context, index) {
        final item = inventoryItems[index];
        return _buildInventoryItem(context, item);
      },
    );
  }

  Widget _buildInventoryItem(BuildContext context, Item item) {
    final config = ItemRegistry.tryGet(item.configId);
    if (config == null) return const SizedBox.shrink();

    final isEquipped = item.id == gameState.player.equippedWeaponId ||
        item.id == gameState.player.equippedArmorId;

    return ListTile(
      leading: _buildItemIcon(config),
      title: Text(
        config.name,
        style: TextStyle(
          color: isEquipped ? Colors.amber : Colors.white,
          fontWeight: isEquipped ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        config.description,
        style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: item.quantity > 1
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'x${item.quantity}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          : (isEquipped
              ? const Icon(Icons.check_circle, color: Colors.amber, size: 20)
              : null),
      onTap: () => _showItemActions(context, item, config, isEquipped),
    );
  }

  Widget _buildItemIcon(ItemConfig config) {
    final color = _getItemColor(config.type);
    final rarityColor = _getRarityColor(config.rarity);

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: rarityColor, width: 2),
      ),
      child: Icon(
        _getItemIcon(config.type),
        color: Colors.white,
        size: 18,
      ),
    );
  }

  Color _getItemColor(ItemType type) {
    return switch (type) {
      ItemType.weapon => const Color(0xFFCCCCCC),
      ItemType.armor => const Color(0xFF8888AA),
      ItemType.consumable => const Color(0xFFFF6666),
      ItemType.key => const Color(0xFFFFD700),
      ItemType.treasure => const Color(0xFFFFFF00),
    };
  }

  Color _getRarityColor(ItemRarity rarity) {
    return switch (rarity) {
      ItemRarity.common => const Color(0xFFAAAAAA),
      ItemRarity.uncommon => const Color(0xFF00FF00),
      ItemRarity.rare => const Color(0xFF0066FF),
      ItemRarity.epic => const Color(0xFFAA00FF),
      ItemRarity.legendary => const Color(0xFFFFAA00),
    };
  }

  IconData _getItemIcon(ItemType type) {
    return switch (type) {
      ItemType.weapon => Icons.gavel,
      ItemType.armor => Icons.shield,
      ItemType.consumable => Icons.local_drink,
      ItemType.key => Icons.vpn_key,
      ItemType.treasure => Icons.paid,
    };
  }

  void _showItemActions(
    BuildContext context,
    Item item,
    ItemConfig config,
    bool isEquipped,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                config.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(color: Colors.grey, height: 1),
            if (config.type == ItemType.consumable)
              ListTile(
                leading: const Icon(Icons.local_drink, color: Colors.green),
                title: const Text('Use', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  onAction(PlayerUseItemAction(item.id));
                  onClose();
                },
              ),
            if ((config.type == ItemType.weapon ||
                    config.type == ItemType.armor) &&
                !isEquipped)
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.amber),
                title: const Text('Equip', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  onAction(PlayerEquipAction(item.id));
                },
              ),
            if (isEquipped)
              ListTile(
                leading: const Icon(Icons.remove_circle, color: Colors.orange),
                title: const Text('Unequip', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  final slot = config.type == ItemType.weapon
                      ? EquipmentSlot.weapon
                      : EquipmentSlot.armor;
                  onAction(PlayerUnequipAction(slot));
                },
              ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Drop', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                onAction(PlayerDropAction(item.id));
                onClose();
              },
            ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.grey),
              title: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
