import 'dart:async';

import 'events.dart';

/// A singleton event bus for publishing and subscribing to game events.
///
/// The EventBus provides a decoupled communication mechanism between
/// different parts of the game. Systems can fire events without knowing
/// who will handle them, and listeners can subscribe to specific event
/// types without knowing who fired them.
///
/// Usage:
/// ```dart
/// // Subscribe to events
/// EventBus.instance.on<DamageDealtEvent>().listen((event) {
///   print('${event.attackerId} dealt ${event.damage} damage!');
/// });
///
/// // Fire events
/// EventBus.instance.fire(DamageDealtEvent('player', 'goblin', 10, false));
/// ```
class EventBus {
  static final EventBus _instance = EventBus._();
  static EventBus get instance => _instance;

  final _controller = StreamController<GameEvent>.broadcast();

  EventBus._();

  /// Returns a stream of events of the specified type.
  ///
  /// Use this to subscribe to specific event types:
  /// ```dart
  /// EventBus.instance.on<EntityMovedEvent>().listen((event) {
  ///   // Handle movement
  /// });
  /// ```
  Stream<T> on<T extends GameEvent>() =>
      _controller.stream.where((event) => event is T).cast<T>();

  /// Fires an event to all listeners.
  ///
  /// The event will be delivered to all streams that match the event type.
  void fire(GameEvent event) => _controller.add(event);

  /// Disposes of the event bus and closes the stream controller.
  ///
  /// This should only be called when the game is shutting down.
  void dispose() => _controller.close();
}
