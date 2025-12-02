import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_teste/providers/game_provider.dart' show GameProvider;
import 'package:flutter_teste/screen/catalogo_screen.dart'
    show GamesCatalogScreen;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameProvider>(
      create: (context) => GameProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Game Catalog',
            theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
            home: const GamesCatalogScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
