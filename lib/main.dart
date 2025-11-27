import 'package:flutter/material.dart';
import 'package:flutter_teste/catalogo_screen.dart';
import 'package:flutter_teste/custom_change_notifier.dart';
import 'package:flutter_teste/login_screen.dart';
import 'package:flutter_teste/game_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameProvider>(
      // Especifique o tipo genérico aqui
      create: () => GameProvider(), // Remova o parâmetro context
      child: MaterialApp(
        title: 'GameHub - Catálogo de Jogos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF667EEA),
            primary: const Color(0xFF667EEA),
            secondary: const Color(0xFF764BA2),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: 'Inter',
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/catalog': (context) => const GamesCatalogScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
