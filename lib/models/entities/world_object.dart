import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'world_object.freezed.dart';
part 'world_object.g.dart';

/// Type of world object (interactive objects on tiles).
enum WorldObjectType {
  /// A portal that connects two locations.
  portal,

  // Future: chest, lever, sign, shrine, etc.
}

/// Base class for interactive world objects that exist on tiles.
///
/// World objects are static, interactive entities on the map, like
/// portals, chests, levers, or signs. Unlike monsters, they don't
/// move or take turns, but the player can interact with them.
@freezed
class WorldObject with _$WorldObject {
  const WorldObject._();

  const factory WorldObject({
    /// Unique instance ID for this world object.
    required String id,

    /// Type of this world object.
    required WorldObjectType type,

    /// Position on the map.
    required Position position,

    /// Reference to specific config (e.g., portal definition ID).
    required String configId,

    /// Whether the player can interact with this object.
    @Default(true) bool isInteractable,
  }) = _WorldObject;

  factory WorldObject.fromJson(Map<String, dynamic> json) =>
      _$WorldObjectFromJson(json);

  /// X coordinate on the map.
  int get x => position.x;

  /// Y coordinate on the map.
  int get y => position.y;

  /// Returns true if this is a portal.
  bool get isPortal => type == WorldObjectType.portal;
}
