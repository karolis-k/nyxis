import 'package:uuid/uuid.dart';

import 'entity.dart';
import 'world_object.dart';

/// Factory methods for creating portal WorldObjects.
///
/// Portals are bidirectional connections between locations.
/// Each portal has an instance on each side (dungeon and surface),
/// but both reference the same portal definition ID.
class Portal {
  Portal._();

  static const _uuid = Uuid();

  /// Create a portal world object.
  static WorldObject create({
    required String portalId,
    required Position position,
  }) {
    return WorldObject(
      id: 'portal_${portalId}_${_uuid.v4().substring(0, 8)}',
      type: WorldObjectType.portal,
      position: position,
      configId: portalId,
    );
  }

  /// Check if a world object is a portal.
  static bool isPortal(WorldObject obj) => obj.type == WorldObjectType.portal;

  /// Get portal definition ID from a portal world object.
  static String getPortalId(WorldObject obj) => obj.configId;
}
