// game_model.dart
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
