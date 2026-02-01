import 'dungeon_generator.dart';
import 'location_generator.dart';
import 'surface_generator.dart';

/// Registry for location generators.
///
/// Maps generator type strings (from LocationConfig.generatorType)
/// to actual LocationGenerator implementations.
class GeneratorRegistry {
  GeneratorRegistry._();

  static final Map<String, LocationGenerator> _generators = {};
  static bool _initialized = false;

  /// Default map dimensions for generators.
  static const int defaultWidth = 50;
  static const int defaultHeight = 40;

  /// Registers a generator with the given type name.
  static void register(String type, LocationGenerator generator) {
    _generators[type] = generator;
  }

  /// Gets a generator by type name.
  ///
  /// Falls back to 'dungeon' generator if the type is not found.
  static LocationGenerator get(String type) {
    return _generators[type] ?? _generators['dungeon']!;
  }

  /// Clears all registered generators.
  static void clear() {
    _generators.clear();
    _initialized = false;
  }

  /// Registers all default generators.
  static void registerAll() {
    if (_initialized) return;

    register('dungeon', DungeonGenerator(
      width: defaultWidth,
      height: defaultHeight,
    ));
    register('surface', SurfaceGenerator(
      width: 30,
      height: 25,
    ));

    _initialized = true;
  }
}
