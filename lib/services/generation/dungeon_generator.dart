import 'dart:math';

import '../../config/location_config.dart';
import '../../models/world/location.dart';
import '../../models/world/map.dart';
import '../../models/world/tile.dart';
import 'corridor.dart';
import 'default_layout_behavior.dart';
import 'generation_context.dart';
import 'generation_step.dart';
import 'layout_behavior.dart';
import 'location_generator.dart';
import 'steps/steps.dart';

/// Main dungeon generator that orchestrates the procedural generation pipeline.
///
/// This is the primary entry point for dungeon generation. It coordinates
/// the entire generation process by:
///
/// 1. Creating a [GenerationContext] to hold mutable state
/// 2. Using a [LayoutBehavior] to place rooms and define connections
/// 3. Executing a pipeline of [GenerationStep]s to carve out the dungeon
/// 4. Building a final [GameMap] from the generated tiles
/// 5. Returning a complete [Location] ready for gameplay
///
/// ## Usage
///
/// ```dart
/// final generator = DungeonGenerator(
///   layout: DefaultLayoutBehavior(),
///   width: 50,
///   height: 40,
/// );
///
/// final location = generator.generate(
///   config: dungeonConfig,
///   floor: 1,
///   random: Random(seed),
/// );
/// ```
///
/// ## Customization
///
/// The generator can be customized in several ways:
///
/// - **Layout Behavior**: Swap the [layout] to change how rooms are placed
///   and connected. Options include grid-based, organic, or linear layouts.
///
/// - **Dimensions**: Adjust [width] and [height] to create larger or smaller
///   dungeons.
///
/// - **Pipeline Steps**: The internal pipeline can be extended by creating
///   custom [GenerationStep] implementations.
///
/// ## Pipeline Steps
///
/// The default generation pipeline includes:
///
/// 1. [RoomCreationStep] - Carves floor tiles for each room
/// 2. [CorridorStep] - Carves corridors connecting rooms
/// 3. [ConnectivityStep] - Ensures all areas are reachable
/// 4. [StairsStep] - Places stairs up and down
///
/// See also:
/// - [LocationGenerator] - The abstract interface this implements
/// - [LayoutBehavior] - Interface for room layout strategies
/// - [GenerationStep] - Interface for pipeline steps
/// - [GenerationContext] - The mutable context passed through the pipeline
class DungeonGenerator implements LocationGenerator {
  /// The layout behavior for room placement and connection.
  ///
  /// Determines how rooms are positioned within the dungeon bounds
  /// and which rooms should be connected by corridors.
  final LayoutBehavior layout;

  /// Map width in tiles.
  ///
  /// This defines the horizontal dimension of the generated dungeon.
  /// Larger values create more spacious dungeons but may require
  /// more processing time.
  final int width;

  /// Map height in tiles.
  ///
  /// This defines the vertical dimension of the generated dungeon.
  /// Larger values create more spacious dungeons but may require
  /// more processing time.
  final int height;

  /// Creates a new dungeon generator with the specified parameters.
  ///
  /// - [layout]: The room layout behavior to use. Defaults to
  ///   [DefaultLayoutBehavior] which places rooms randomly with
  ///   minimum spanning tree connections.
  /// - [width]: The map width in tiles. Defaults to 40.
  /// - [height]: The map height in tiles. Defaults to 30.
  DungeonGenerator({
    this.layout = const DefaultLayoutBehavior(),
    this.width = 40,
    this.height = 30,
  });

  @override
  Location generate({
    required LocationConfig config,
    required int floor,
    required Random random,
  }) {
    // 1. Create GenerationContext to hold mutable state
    final context = GenerationContext(
      width: width,
      height: height,
      random: random,
      configId: config.id,
      floor: floor,
      maxDepth: config.maxDepth,
    );

    // 2. Generate room layout using the layout behavior
    context.rooms = layout.generateRooms(context);

    // 3. Define room connections based on layout strategy
    final connections = layout.defineConnections(context.rooms, context);

    // 4. Convert connection pairs to Corridor objects
    for (final (roomA, roomB) in connections) {
      context.corridors.add(Corridor(
        startX: context.rooms[roomA].centerX,
        startY: context.rooms[roomA].centerY,
        endX: context.rooms[roomB].centerX,
        endY: context.rooms[roomB].centerY,
      ));
    }

    // 5. Build and execute the generation pipeline
    final pipeline = _buildPipeline();
    for (final step in pipeline) {
      step.execute(context);
    }

    // 6. Build GameMap from the generation context
    final gameMap = _buildGameMap(context);

    // 7. Create and return the complete Location
    return Location.create(
      configId: config.id,
      floor: floor,
      map: gameMap,
    );
  }

  /// Builds the generation pipeline.
  ///
  /// Returns an ordered list of [GenerationStep]s that will be
  /// executed sequentially to generate the dungeon.
  List<GenerationStep> _buildPipeline() {
    return [
      RoomCreationStep(),
      CorridorStep(),
      ConnectivityStep(),
      StairsStep(),
    ];
  }

  /// Builds a [GameMap] from the generation context.
  ///
  /// Converts the [TileType] grid in the context to a proper
  /// [GameMap] with [Tile] objects.
  GameMap _buildGameMap(GenerationContext context) {
    // Convert TileType grid to Tile objects
    final tiles = List.generate(context.height, (y) {
      return List.generate(context.width, (x) {
        final type = context.tiles[y][x];
        return _createTile(type);
      });
    });

    return GameMap(
      width: context.width,
      height: context.height,
      tiles: tiles,
    );
  }

  /// Creates a [Tile] from a [TileType].
  ///
  /// Maps each tile type to its corresponding factory constructor,
  /// setting appropriate properties like walkability.
  Tile _createTile(TileType type) {
    return switch (type) {
      TileType.floor => Tile.floor(),
      TileType.wall => Tile.wall(),
      TileType.stairsUp => Tile.stairsUp(),
      TileType.stairsDown => Tile.stairsDown(),
      TileType.door => Tile.door(),
      TileType.water => Tile.water(),
      TileType.lava => Tile.lava(),
    };
  }
}
