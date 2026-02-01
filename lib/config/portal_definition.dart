import 'package:freezed_annotation/freezed_annotation.dart';

part 'portal_definition.freezed.dart';
part 'portal_definition.g.dart';

/// Defines a bidirectional portal connection between two locations.
///
/// Portals connect locations together, allowing the player to travel
/// between dungeons and their surface locations (and vice versa).
@freezed
class PortalDefinition with _$PortalDefinition {
  const PortalDefinition._();

  const factory PortalDefinition({
    /// Unique portal ID (e.g., 'dark_dungeon_to_surface')
    required String id,

    /// First location config ID
    required String location1,

    /// Second location config ID
    required String location2,

    /// Display name when viewing from location1
    required String displayName1,

    /// Display name when viewing from location2
    required String displayName2,

    /// Floor in location1 where portal appears
    required int floor1,

    /// Floor in location2 where portal appears
    required int floor2,
  }) = _PortalDefinition;

  factory PortalDefinition.fromJson(Map<String, dynamic> json) =>
      _$PortalDefinitionFromJson(json);

  /// Returns the display name when viewing from a specific location.
  String getDisplayName(String fromLocationId) {
    if (fromLocationId == location1) {
      return displayName1;
    } else if (fromLocationId == location2) {
      return displayName2;
    }
    return 'Portal';
  }

  /// Returns the destination location ID when traveling from a specific location.
  String? getDestinationLocation(String fromLocationId) {
    if (fromLocationId == location1) {
      return location2;
    } else if (fromLocationId == location2) {
      return location1;
    }
    return null;
  }

  /// Returns the destination floor when traveling from a specific location.
  int? getDestinationFloor(String fromLocationId) {
    if (fromLocationId == location1) {
      return floor2;
    } else if (fromLocationId == location2) {
      return floor1;
    }
    return null;
  }
}
