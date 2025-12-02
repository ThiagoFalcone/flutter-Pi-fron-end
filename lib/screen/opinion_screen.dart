// screens/opinion_screen.dart
import 'package:flutter/material.dart';
import '../models/game_model.dart';

class OpinionScreen extends StatefulWidget {
  final Game? game;

  const OpinionScreen({super.key, this.game});

  @override
  State<OpinionScreen> createState() => _OpinionScreenState();
}

class _OpinionScreenState extends State<OpinionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.game != null
              ? 'Opiniões sobre ${widget.game!.title}'
              : 'Todas as Opiniões',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.reviews, size: 64, color: Colors.grey),
              SizedBox(height: 20),
              Text(
                widget.game != null
                    ? 'Opiniões sobre ${widget.game!.title}'
                    : 'Todas as Opiniões',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Funcionalidade em desenvolvimento...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
