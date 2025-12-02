// models/opinion.dart
import 'package:flutter/material.dart';

class Opinion {
  final String id;
  final String gameId;
  final String userId;
  final double rating;
  final String title;
  final String review;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int playtime;
  final bool recommended;
  final int likes;
  final int dislikes;
  final List<String> likedBy;
  final List<String> dislikedBy;

  Opinion({
    required this.id,
    required this.gameId,
    required this.userId,
    required this.rating,
    required this.title,
    required this.review,
    required this.tags,
    required this.createdAt,
    this.updatedAt,
    required this.playtime,
    required this.recommended,
    this.likes = 0,
    this.dislikes = 0,
    this.likedBy = const [],
    this.dislikedBy = const [],
  });

  // Método copyWith
  Opinion copyWith({
    String? id,
    String? gameId,
    String? userId,
    double? rating,
    String? title,
    String? review,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? playtime,
    bool? recommended,
    int? likes,
    int? dislikes,
    List<String>? likedBy,
    List<String>? dislikedBy,
  }) {
    return Opinion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      review: review ?? this.review,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      playtime: playtime ?? this.playtime,
      recommended: recommended ?? this.recommended,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      likedBy: likedBy ?? this.likedBy,
      dislikedBy: dislikedBy ?? this.dislikedBy,
    );
  }

  // Método para converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameId': gameId,
      'userId': userId,
      'rating': rating,
      'title': title,
      'review': review,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'playtime': playtime,
      'recommended': recommended,
      'likes': likes,
      'dislikes': dislikes,
      'likedBy': likedBy,
      'dislikedBy': dislikedBy,
    };
  }

  // Método para criar a partir de JSON
  factory Opinion.fromJson(Map<String, dynamic> json) {
    return Opinion(
      id: json['id']?.toString() ?? '',
      gameId: json['gameId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      title: json['title']?.toString() ?? '',
      review: json['review']?.toString() ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      playtime: (json['playtime'] as int?) ?? 0,
      recommended: json['recommended'] == true,
      likes: (json['likes'] as int?) ?? 0,
      dislikes: (json['dislikes'] as int?) ?? 0,
      likedBy:
          (json['likedBy'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      dislikedBy:
          (json['dislikedBy'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  // Métodos auxiliares
  String getFormattedDate() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays == 0) {
      return 'Hoje';
    } else if (difference.inDays == 1) {
      return 'Ontem';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'semana' : 'semanas'} atrás';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }

  String getFormattedRating() {
    return '${rating.toStringAsFixed(1)}/5.0';
  }

  Color getRatingColor() {
    if (rating >= 4.0) return Colors.green;
    if (rating >= 3.0) return Colors.blue;
    if (rating >= 2.0) return Colors.orange;
    return Colors.red;
  }

  bool hasUserLiked(String userId) => likedBy.contains(userId);
  bool hasUserDisliked(String userId) => dislikedBy.contains(userId);

  @override
  String toString() {
    return 'Opinion(id: $id, gameId: $gameId, rating: $rating, title: $title)';
  }
}
