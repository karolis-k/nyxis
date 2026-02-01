/// Core data classes and interfaces for the dungeon generation system.
///
/// This library provides the fundamental building blocks for procedural
/// dungeon generation:
///
/// **Data Classes:**
/// - [Room] - Rectangular room definitions
/// - [Corridor] - Connections between rooms
/// - [GenerationContext] - Mutable state for the generation pipeline
///
/// **Interfaces:**
/// - [GenerationStep] - Pipeline step interface
/// - [LayoutBehavior] - Room layout strategy interface
/// - [LocationGenerator] - Location generator interface
///
/// **Implementations:**
/// - [DungeonGenerator] - Main dungeon generator
/// - [DefaultLayoutBehavior] - Standard room placement strategy
library;

export 'corridor.dart';
export 'default_layout_behavior.dart';
export 'dungeon_generator.dart';
export 'generation_context.dart';
export 'generation_step.dart';
export 'generator_registry.dart';
export 'layout_behavior.dart';
export 'location_generator.dart';
export 'portal_placement.dart';
export 'room.dart';
export 'steps/steps.dart';
export 'surface_generator.dart';
