import 'dart:convert';
import 'package:flutter_teste/utils/api_config.dart';
import 'package:http/http.dart' as http;
import '../models/game_model.dart';

class GameService {
  Future<List<Game>> getGames() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/jogo'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Game.fromBackendJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar jogos.');
    }
  }

  Future<List> getGamesByIds(List<String> ids) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/jogo/by-ids?ids=${ids.join(',')}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Game.fromBackendJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Erro ao buscar jogos.');
      return [];
    }
  }

  Future<List<Game>> getPopularGames() async {
    // Implemente a lógica para buscar jogos populares
    return []; // Retornar lista de jogos
  }

  Future<Game?> getGameById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/jogo/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Game.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Erro ao buscar jogo.');
      return null;
    }
  }
}
