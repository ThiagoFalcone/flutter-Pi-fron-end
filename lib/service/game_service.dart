// services/game_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';

class GameService {
  final String _baseUrl = 'https://api.example.com/games'; // Sua URL da API

  Future<List> getGamesByIds(List<String> ids) async {
    try {
      // Implemente a lógica para buscar jogos por IDs do seu catálogo
      // Esta é uma implementação de exemplo
      final response = await http.get(
        Uri.parse('$_baseUrl/by-ids?ids=${ids.join(',')}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Game.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Erro ao buscar jogos: $e');
      return [];
    }
  }

  Future<List<Game>> getPopularGames() async {
    // Implemente a lógica para buscar jogos populares
    return []; // Retornar lista de jogos
  }

  Future<Game?> getGameById(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Game.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Erro ao buscar jogo: $e');
      return null;
    }
  }
}
