// models/game_model.dart
// ignore_for_file: unused_import

import 'dart:convert';

class Game {
  final String id;
  final String title;
  final String developer;
  final String publisher;
  final double price;
  final double rating;
  final String coverUrl;
  final String description;
  final String category;
  final List<String> platforms;
  final int releaseYear;
  final bool isCompleted;
  final DateTime? completionDate;
  final int playtime;
  final String platform;
  final bool isInLibrary;

  Game({
    required this.id,
    required this.title,
    required this.developer,
    required this.publisher,
    required this.price,
    required this.rating,
    required this.coverUrl,
    required this.description,
    required this.category,
    required this.platforms,
    required this.releaseYear,
    required this.isCompleted,
    this.completionDate,
    required this.playtime,
    required this.platform,
    required this.isInLibrary,
  });

  // Fixed copyWith method
  Game copyWith({
    String? id,
    String? title,
    String? developer,
    String? publisher,
    double? price,
    double? rating,
    String? coverUrl,
    String? description,
    String? category,
    List<String>? platforms,
    int? releaseYear,
    bool? isCompleted,
    DateTime? completionDate,
    int? playtime,
    String? platform,
    bool? isInLibrary,
  }) {
    return Game(
      id: id ?? this.id,
      title: title ?? this.title,
      developer: developer ?? this.developer,
      publisher: publisher ?? this.publisher,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      coverUrl: coverUrl ?? this.coverUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      platforms: platforms ?? this.platforms,
      releaseYear: releaseYear ?? this.releaseYear,
      isCompleted: isCompleted ?? this.isCompleted,
      completionDate: completionDate ?? this.completionDate,
      playtime: playtime ?? this.playtime,
      platform: platform ?? this.platform,
      isInLibrary: isInLibrary ?? this.isInLibrary,
    );
  }

  // Método para criar a partir de JSON
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      developer: json['developer']?.toString() ?? '',
      publisher: json['publisher']?.toString() ?? '',
      price: _parseDouble(json['price']),
      rating: _parseDouble(json['rating']),
      coverUrl: json['coverUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      platforms: _parseStringList(json['platforms']),
      releaseYear: _parseInt(json['releaseYear']),
      isCompleted: json['isCompleted'] == true,
      completionDate: _parseDateTime(json['completionDate']),
      playtime: _parseInt(json['playtime']),
      platform: json['platform']?.toString() ?? '',
      isInLibrary: json['isInLibrary'] == true,
    );
  }

  // Método para converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'developer': developer,
      'publisher': publisher,
      'price': price,
      'rating': rating,
      'coverUrl': coverUrl,
      'description': description,
      'category': category,
      'platforms': platforms,
      'releaseYear': releaseYear,
      'isCompleted': isCompleted,
      'completionDate': completionDate?.toIso8601String(),
      'playtime': playtime,
      'platform': platform,
      'isInLibrary': isInLibrary,
    };
  }

  // Métodos auxiliares para parse seguro
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return [];
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  // Métodos auxiliares
  String getFormattedPrice() {
    return 'R\$${price.toStringAsFixed(2)}';
  }

  String getFormattedRating() {
    return rating.toStringAsFixed(1);
  }

  String getReleaseYearString() {
    return releaseYear.toString();
  }

  String getFormattedPlaytime() {
    return '${playtime}h';
  }

  @override
  String toString() {
    return 'Game(id: $id, title: $title, playtime: ${playtime}h)';
  }
}

// Classe GameSave (opcional, manter no mesmo arquivo ou separar)
class GameSave {
  final String id;
  final String gameId;
  final DateTime saveDate;
  final int playtimeHours;
  final String? notes;
  final String? saveName;

  GameSave({
    required this.id,
    required this.gameId,
    required this.saveDate,
    required this.playtimeHours,
    this.notes,
    this.saveName,
  });

  GameSave copyWith({
    String? id,
    String? gameId,
    DateTime? saveDate,
    int? playtimeHours,
    String? notes,
    String? saveName,
  }) {
    return GameSave(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      saveDate: saveDate ?? this.saveDate,
      playtimeHours: playtimeHours ?? this.playtimeHours,
      notes: notes ?? this.notes,
      saveName: saveName ?? this.saveName,
    );
  }

  // Método para converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameId': gameId,
      'saveDate': saveDate.toIso8601String(),
      'playtimeHours': playtimeHours,
      'notes': notes,
      'saveName': saveName,
    };
  }

  // Método para criar a partir de JSON
  factory GameSave.fromJson(Map<String, dynamic> json) {
    return GameSave(
      id: json['id']?.toString() ?? '',
      gameId: json['gameId']?.toString() ?? '',
      saveDate: DateTime.parse(json['saveDate'] as String),
      playtimeHours: json['playtimeHours'] as int,
      notes: json['notes']?.toString(),
      saveName: json['saveName']?.toString(),
    );
  }
}
