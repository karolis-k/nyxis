import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/item_config.dart';
import 'config/monster_config.dart';
import 'services/save_service.dart';
import 'ui/screens/game_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize registries
  MonsterRegistry.registerAll();
  ItemRegistry.registerAll();

  // Initialize save service
  await SaveService.instance.init();

  // Lock orientation to landscape for better gameplay
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const NyxisApp());
}

class NyxisApp extends StatelessWidget {
  const NyxisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyxis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const GameWrapper(),
    );
  }
}
