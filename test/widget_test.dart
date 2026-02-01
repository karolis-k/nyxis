// Basic smoke test for the Nyxis roguelike game.

import 'package:flutter_test/flutter_test.dart';

import 'package:roguelike_game/main.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NyxisApp());

    // Verify the app starts (game screen should be displayed)
    // More detailed tests can be added as the game develops
    expect(find.byType(NyxisApp), findsOneWidget);
  });
}
