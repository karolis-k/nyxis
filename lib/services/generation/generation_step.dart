import 'generation_context.dart';

/// Abstract interface for a single step in the dungeon generation pipeline.
///
/// Generation steps are executed sequentially to build up a complete dungeon.
/// Each step can read from and modify the [GenerationContext], allowing steps
/// to build upon the work of previous steps.
///
/// Example steps might include:
/// - Room placement
/// - Corridor carving
/// - Door placement
/// - Monster spawning
/// - Item distribution
abstract class GenerationStep {
  /// Execute this step on the generation context.
  ///
  /// The step should read any required data from [context] and write its
  /// results back to the context for subsequent steps to use.
  void execute(GenerationContext context);
}
