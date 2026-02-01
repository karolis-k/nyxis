import 'portal_definition.dart';

/// Registry for portal definitions that connect locations.
///
/// Portals are bidirectional connections between locations. Each portal
/// has two endpoints - one in each location it connects.
class PortalRegistry {
  PortalRegistry._();

  static final Map<String, PortalDefinition> _portals = {};
  static bool _initialized = false;

  /// Registers a portal definition.
  static void register(PortalDefinition portal) {
    _portals[portal.id] = portal;
  }

  /// Gets a portal definition by ID.
  static PortalDefinition? getById(String id) {
    return _portals[id];
  }

  /// Get portal IDs that should be placed for a location on a specific floor.
  static List<String> getPortalIdsForLocation(String locationId, int floor) {
    return _portals.values
        .where((p) =>
            (p.location1 == locationId && p.floor1 == floor) ||
            (p.location2 == locationId && p.floor2 == floor))
        .map((p) => p.id)
        .toList();
  }

  /// Get destination info for a portal from a given location.
  ///
  /// Returns null if the portal doesn't connect to this location.
  static ({String locationId, int floor, String displayName})?
      getDestination(String portalId, String fromLocationId) {
    final def = getById(portalId);
    if (def == null) return null;

    if (def.location1 == fromLocationId) {
      return (
        locationId: def.location2,
        floor: def.floor2,
        displayName: def.displayName1,
      );
    } else if (def.location2 == fromLocationId) {
      return (
        locationId: def.location1,
        floor: def.floor1,
        displayName: def.displayName2,
      );
    }
    return null;
  }

  /// Clears all registered portals.
  static void clear() {
    _portals.clear();
    _initialized = false;
  }

  /// Registers all default portal definitions.
  static void registerAll() {
    if (_initialized) return;

    for (final portal in _defaultPortals) {
      register(portal);
    }

    _initialized = true;
  }
}

/// Default portal definitions for the game.
const List<PortalDefinition> _defaultPortals = [
  // Dark Dungeon floor 0 <-> Dark Dungeon Surface
  PortalDefinition(
    id: 'dark_dungeon_to_surface',
    location1: 'dark_dungeon',
    location2: 'dark_dungeon_surface',
    displayName1: 'Exit to Surface',
    displayName2: 'Entrance to Dungeon',
    floor1: 0,
    floor2: 0,
  ),
  // Goblin Cave floor 0 <-> Goblin Cave Surface
  PortalDefinition(
    id: 'goblin_cave_to_surface',
    location1: 'goblin_cave',
    location2: 'goblin_cave_surface',
    displayName1: 'Exit to Surface',
    displayName2: 'Entrance to Cave',
    floor1: 0,
    floor2: 0,
  ),
];
