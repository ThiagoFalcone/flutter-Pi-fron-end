// models/user_profile.dart
// ignore_for_file: avoid_print

import 'game_model.dart';

class UserProfile {
  final String id;
  final String username;
  final String email;
  final String? steamId;
  final String? psnId;
  final String? xboxId;
  final String? nintendoId;
  final List<Game> completedGames;
  final int totalPlaytime;
  final String? avatarUrl;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    this.steamId,
    this.psnId,
    this.xboxId,
    this.nintendoId,
    required this.completedGames,
    required this.totalPlaytime,
    this.avatarUrl,
  });

  // CopyWith method for UserProfile
  UserProfile copyWith({
    String? id,
    String? username,
    String? email,
    String? steamId,
    String? psnId,
    String? xboxId,
    String? nintendoId,
    List<Game>? completedGames,
    int? totalPlaytime,
    String? avatarUrl,
  }) {
    return UserProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      steamId: steamId ?? this.steamId,
      psnId: psnId ?? this.psnId,
      xboxId: xboxId ?? this.xboxId,
      nintendoId: nintendoId ?? this.nintendoId,
      completedGames: completedGames ?? this.completedGames,
      totalPlaytime: totalPlaytime ?? this.totalPlaytime,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  // Método para converter para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'steamId': steamId,
      'psnId': psnId,
      'xboxId': xboxId,
      'nintendoId': nintendoId,
      'completedGames': completedGames.map((game) => game.toJson()).toList(),
      'totalPlaytime': totalPlaytime,
      'avatarUrl': avatarUrl,
    };
  }

  // Método para criar a partir de Map
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    // Converter lista de jogos de forma segura
    final List<Game> completedGamesList = [];

    if (map['completedGames'] != null && map['completedGames'] is List) {
      final List<dynamic> rawList = map['completedGames'] as List<dynamic>;

      for (var item in rawList) {
        if (item is Map<String, dynamic>) {
          try {
            final game = Game.fromJson(item);
            completedGamesList.add(game);
          } catch (e) {
            print('Erro ao converter jogo: $e');
          }
        }
      }
    }

    return UserProfile(
      id: map['id']?.toString() ?? '',
      username: map['username']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      steamId: map['steamId']?.toString(),
      psnId: map['psnId']?.toString(),
      xboxId: map['xboxId']?.toString(),
      nintendoId: map['nintendoId']?.toString(),
      completedGames: completedGamesList,
      totalPlaytime: _parseInt(map['totalPlaytime']),
      avatarUrl: map['avatarUrl']?.toString(),
    );
  }

  // Método para criar a partir de JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile.fromMap(json);
  }

  // Método para converter para JSON
  Map<String, dynamic> toJson() => toMap();

  // Método auxiliar para parse seguro de inteiros
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, username: $username, email: $email, completedGames: ${completedGames.length}, totalPlaytime: $totalPlaytime)';
  }
}
