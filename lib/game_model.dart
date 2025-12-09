// game_model.dart
import 'package:flutter/material.dart';

// Enum para status dos jogos
enum GameStatus {
  wantToPlay('Quero Jogar', Icons.bookmark_outline, Colors.blue),
  playing('Jogando', Icons.play_circle_outline, Colors.green),
  completed('Completado', Icons.check_circle, Colors.purple),
  paused('Pausado', Icons.pause_circle_outline, Colors.orange),
  abandoned('Abandonado', Icons.cancel_outlined, Colors.red);

  final String label;
  final IconData icon;
  final Color color;

  const GameStatus(this.label, this.icon, this.color);
}

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
}

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
  final GameStatus gameStatus;

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
    this.gameStatus = GameStatus.wantToPlay,
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
    GameStatus? gameStatus,
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
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }
}

// game_model.dart - Adicione estas classes
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
}

// Modelo para avaliações e comentários
class GameReview {
  final String id;
  final String gameId;
  final String userId;
  final String username;
  final String? avatarUrl;
  final int rating; // 1 a 5 estrelas
  final String comment;
  final DateTime reviewDate;
  final int likes;
  final List<String> likedBy; // IDs dos usuários que curtiram

  GameReview({
    required this.id,
    required this.gameId,
    required this.userId,
    required this.username,
    this.avatarUrl,
    required this.rating,
    required this.comment,
    required this.reviewDate,
    this.likes = 0,
    this.likedBy = const [],
  });

  GameReview copyWith({
    String? id,
    String? gameId,
    String? userId,
    String? username,
    String? avatarUrl,
    int? rating,
    String? comment,
    DateTime? reviewDate,
    int? likes,
    List<String>? likedBy,
  }) {
    return GameReview(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      reviewDate: reviewDate ?? this.reviewDate,
      likes: likes ?? this.likes,
      likedBy: likedBy ?? this.likedBy,
    );
  }
}

// Modelo para perfis públicos de usuários
class User {
  final String id;
  final String username;
  final String? email;
  final String? avatarUrl;
  final String? bio;
  final int totalGames;
  final int totalPlaytime;
  final int followersCount;
  final int followingCount;
  final List<String> platformIds;
  final bool isFollowing;
  final DateTime? joinDate;

  User({
    required this.id,
    required this.username,
    this.email,
    this.avatarUrl,
    this.bio,
    this.totalGames = 0,
    this.totalPlaytime = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.platformIds = const [],
    this.isFollowing = false,
    this.joinDate,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? avatarUrl,
    String? bio,
    int? totalGames,
    int? totalPlaytime,
    int? followersCount,
    int? followingCount,
    List<String>? platformIds,
    bool? isFollowing,
    DateTime? joinDate,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      totalGames: totalGames ?? this.totalGames,
      totalPlaytime: totalPlaytime ?? this.totalPlaytime,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      platformIds: platformIds ?? this.platformIds,
      isFollowing: isFollowing ?? this.isFollowing,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}
