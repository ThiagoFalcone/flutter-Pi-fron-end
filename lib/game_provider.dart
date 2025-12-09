// game_provider.dart
// ignore_for_file: non_constant_identifier_names

import 'package:flutter_teste/game_repository.dart';
import 'custom_change_notifier.dart';
import 'game_model.dart';

class GameProvider extends CustomChangeNotifier {
  final GameRepository _gameRepository = GameRepository();
  final List<GameSave> _gameSaves = [];
  final List<GameReview> _gameReviews = [];
  
  // ID do usuário atual (simulado - em produção viria de autenticação)
  final String _currentUserId = 'user_1';
  final String _currentUsername = 'GameMaster';
  
  // Lista de usuários e relacionamentos
  final List<User> _users = [];
  final Map<String, List<String>> _followingMap = {}; // userId -> lista de IDs que ele segue

  List<Game> get allGames => _gameRepository.allGames;
  List<Game> get myGames => _gameRepository.myGames;
  List<GameSave> get gameSaves => _gameSaves;
  List<GameReview> get gameReviews => _gameReviews;

  // Método para adicionar jogos à biblioteca
  void addGame(Game game) {
    if (!_gameRepository.myGames.any(
      (existingGame) => existingGame.id == game.id,
    )) {
      _gameRepository.addToLibrary(game.id);
      notifyListeners();
      _saveGamesToLocal();
    }
  }

  // Método para adicionar jogo à biblioteca por ID
  void addToLibrary(String gameId) {
    _gameRepository.addToLibrary(gameId);
    notifyListeners();
    _saveGamesToLocal();
  }

  // Método para remover jogo da biblioteca
  void removeFromLibrary(String id) {
    _gameRepository.removeFromLibrary(id);
    notifyListeners();
    _saveGamesToLocal();
  }

  // Método para alternar status da biblioteca
  void toggleLibraryStatus(String gameId) {
    _gameRepository.toggleLibraryStatus(gameId);
    notifyListeners();
    _saveGamesToLocal();
  }

  // Método para atualizar o status do jogo
  void updateGameStatus(String gameId, GameStatus status) {
    _gameRepository.updateGameStatus(gameId, status);
    notifyListeners();
    _saveGamesToLocal();
  }

  // Método para verificar se um jogo está na biblioteca
  bool isGameInLibrary(String gameId) {
    return _gameRepository.myGames.any((game) => game.id == gameId);
  }

  // Método para obter um jogo pelo ID
  Game? getGameById(String gameId) {
    try {
      return _gameRepository.allGames.firstWhere((game) => game.id == gameId);
    } catch (e) {
      return null;
    }
  }

  // Método para obter jogos por categoria
  List<Game> getGamesByCategory(String category) {
    return _gameRepository.allGames
        .where((game) => game.category == category)
        .toList();
  }

  // Método para obter jogos por plataforma
  List<Game> getGamesByPlatform(String platform) {
    return _gameRepository.allGames
        .where((game) => game.platforms.contains(platform))
        .toList();
  }

  // MÉTODOS PARA GERENCIAR HORAS JOGADAS
  void addPlaytime(
    String gameId,
    int hours, {
    String? notes,
    String? saveName,
  }) {
    final save = GameSave(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      gameId: gameId,
      saveDate: DateTime.now(),
      playtimeHours: hours,
      notes: notes,
      saveName: saveName,
    );

    _gameSaves.add(save);
    _updateTotalPlaytime(gameId);
    notifyListeners();
    _saveSavesToLocal();
  }

  void updateSave(String saveId, int hours, {String? notes, String? saveName}) {
    final index = _gameSaves.indexWhere((save) => save.id == saveId);
    if (index != -1) {
      _gameSaves[index] = _gameSaves[index].copyWith(
        playtimeHours: hours,
        notes: notes,
        saveName: saveName,
      );
      _updateTotalPlaytime(_gameSaves[index].gameId);
      notifyListeners();
      _saveSavesToLocal();
    }
  }

  void deleteSave(String saveId) {
    try {
      final save = _gameSaves.firstWhere((s) => s.id == saveId);
      _gameSaves.removeWhere((s) => s.id == saveId);
      _updateTotalPlaytime(save.gameId);
      notifyListeners();
      _saveSavesToLocal();
    } catch (e) {
      print('Erro ao deletar save: $e');
    }
  }

  List<GameSave> getSavesForGame(String gameId) {
    return _gameSaves.where((save) => save.gameId == gameId).toList();
  }

  int getTotalPlaytimeForGame(String gameId) {
    final gameSaves = getSavesForGame(gameId);
    return gameSaves.fold(0, (total, save) => total + save.playtimeHours);
  }

  void _updateTotalPlaytime(String gameId) {
    final totalPlaytime = getTotalPlaytimeForGame(gameId);
    // Se você quiser armazenar o playtime total no objeto Game,
    // precisaria adicionar um método no GameRepository para atualizar
    print('Total playtime for $gameId: $totalPlaytime hours');
  }

  // PERSISTÊNCIA LOCAL
  void _saveGamesToLocal() {
    // Como o GameRepository já gerencia o estado dos jogos,
    // você pode salvar apenas a lista de IDs dos jogos na biblioteca
    // ou implementar a persistência diretamente no GameRepository
    print('Salvando estado da biblioteca...');
  }

  void _saveSavesToLocal() {
    // Implementar salvamento local dos saves
    print('Salvando saves localmente...');
  }

  void loadGamesFromLocal() {
    // Implementar carregamento local
    // O GameRepository já tem os jogos carregados inicialmente
  }

  void loadSavesFromLocal() {
    // Implementar carregamento local dos saves
  }

  // MÉTODOS DE BUSCA E FILTRO
  List<Game> searchGames(String query) {
    if (query.isEmpty) return _gameRepository.allGames;

    return _gameRepository.allGames
        .where(
          (game) =>
              game.title.toLowerCase().contains(query.toLowerCase()) ||
              game.developer.toLowerCase().contains(query.toLowerCase()) ||
              game.category.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  List<Game> getFeaturedGames() {
    return _gameRepository.allGames
        .where((game) => game.rating >= 4.5)
        .take(5)
        .toList();
  }

  List<Game> getNewReleases() {
    final currentYear = DateTime.now().year;
    return _gameRepository.allGames
        .where((game) => game.releaseYear >= currentYear - 1)
        .toList();
  }

  // MÉTODOS PARA GERENCIAR AVALIAÇÕES E COMENTÁRIOS
  List<GameReview> getReviewsForGame(String gameId) {
    return _gameReviews.where((review) => review.gameId == gameId).toList()
      ..sort((a, b) => b.reviewDate.compareTo(a.reviewDate)); // Mais recentes primeiro
  }

  GameReview? getUserReviewForGame(String gameId) {
    try {
      return _gameReviews.firstWhere(
        (review) => review.gameId == gameId && review.userId == _currentUserId,
      );
    } catch (e) {
      return null;
    }
  }

  double getAverageRatingForGame(String gameId) {
    final reviews = getReviewsForGame(gameId);
    if (reviews.isEmpty) return 0.0;
    final sum = reviews.fold(0.0, (total, review) => total + review.rating);
    return sum / reviews.length;
  }

  void addReview(String gameId, int rating, String comment) {
    // Verificar se o usuário já avaliou este jogo
    final existingReview = getUserReviewForGame(gameId);
    
    if (existingReview != null) {
      // Atualizar avaliação existente
      final index = _gameReviews.indexWhere((r) => r.id == existingReview.id);
      _gameReviews[index] = existingReview.copyWith(
        rating: rating,
        comment: comment,
        reviewDate: DateTime.now(),
      );
    } else {
      // Criar nova avaliação
      final review = GameReview(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        gameId: gameId,
        userId: _currentUserId,
        username: _currentUsername,
        rating: rating,
        comment: comment,
        reviewDate: DateTime.now(),
      );
      _gameReviews.add(review);
    }
    
    notifyListeners();
    _saveReviewsToLocal();
  }

  void deleteReview(String reviewId) {
    _gameReviews.removeWhere((review) => review.id == reviewId);
    notifyListeners();
    _saveReviewsToLocal();
  }

  void toggleLikeReview(String reviewId, String userId) {
    final index = _gameReviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      final review = _gameReviews[index];
      final likedBy = List<String>.from(review.likedBy);
      
      if (likedBy.contains(userId)) {
        likedBy.remove(userId);
      } else {
        likedBy.add(userId);
      }
      
      _gameReviews[index] = review.copyWith(
        likes: likedBy.length,
        likedBy: likedBy,
      );
      notifyListeners();
      _saveReviewsToLocal();
    }
  }

  void _saveReviewsToLocal() {
    // Implementar salvamento local das reviews
    print('Salvando reviews localmente...');
  }

  void loadReviewsFromLocal() {
    // Implementar carregamento local das reviews
    // Por enquanto, adicionar algumas reviews de exemplo
    if (_gameReviews.isEmpty) {
      _gameReviews.addAll([
        GameReview(
          id: 'review_1',
          gameId: '1',
          userId: 'user_2',
          username: 'GamerPro',
          rating: 5,
          comment: 'Jogo incrível! A história é envolvente e os gráficos são de tirar o fôlego.',
          reviewDate: DateTime.now().subtract(const Duration(days: 5)),
          likes: 12,
          likedBy: ['user_3', 'user_4'],
        ),
        GameReview(
          id: 'review_2',
          gameId: '1',
          userId: 'user_3',
          username: 'GameLover',
          rating: 4,
          comment: 'Muito bom, mas poderia ter mais conteúdo pós-jogo.',
          reviewDate: DateTime.now().subtract(const Duration(days: 3)),
          likes: 8,
          likedBy: ['user_2'],
        ),
      ]);
    }
  }

  // MÉTODOS PARA GERENCIAR USUÁRIOS E PERFIS
  List<User> get users => _users;

  void loadUsers() {
    if (_users.isEmpty) {
      // Carregar usuários de exemplo
      _users.addAll([
        User(
          id: 'user_2',
          username: 'GamerPro',
          email: 'gamerpro@example.com',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
          bio: 'Apaixonado por RPGs e jogos de estratégia',
          totalGames: 45,
          totalPlaytime: 1200,
          followersCount: 234,
          followingCount: 89,
          isFollowing: _followingMap[_currentUserId]?.contains('user_2') ?? false,
          joinDate: DateTime(2023, 1, 15),
        ),
        User(
          id: 'user_3',
          username: 'GameLover',
          email: 'gamelover@example.com',
          avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
          bio: 'Streamer e crítico de jogos',
          totalGames: 78,
          totalPlaytime: 2500,
          followersCount: 567,
          followingCount: 123,
          isFollowing: _followingMap[_currentUserId]?.contains('user_3') ?? false,
          joinDate: DateTime(2022, 8, 20),
        ),
        User(
          id: 'user_4',
          username: 'RetroGamer',
          email: 'retro@example.com',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
          bio: 'Colecionador de jogos retrô',
          totalGames: 120,
          totalPlaytime: 3500,
          followersCount: 890,
          followingCount: 234,
          isFollowing: _followingMap[_currentUserId]?.contains('user_4') ?? false,
          joinDate: DateTime(2021, 5, 10),
        ),
        User(
          id: 'user_5',
          username: 'IndieHunter',
          email: 'indie@example.com',
          avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150',
          bio: 'Explorando os melhores jogos indie',
          totalGames: 95,
          totalPlaytime: 1800,
          followersCount: 445,
          followingCount: 156,
          isFollowing: _followingMap[_currentUserId]?.contains('user_5') ?? false,
          joinDate: DateTime(2023, 3, 5),
        ),
      ]);
    }
  }

  List<User> searchUsers(String query) {
    if (query.isEmpty) return _users;
    return _users.where((user) {
      return user.username.toLowerCase().contains(query.toLowerCase()) ||
          (user.bio?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();
  }

  User? getUserById(String userId) {
    try {
      return _users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  void toggleFollow(String userId) {
    if (!_followingMap.containsKey(_currentUserId)) {
      _followingMap[_currentUserId] = [];
    }

    final followingList = _followingMap[_currentUserId]!;
    final userIndex = _users.indexWhere((u) => u.id == userId);
    
    if (userIndex != -1) {
      if (followingList.contains(userId)) {
        // Deixar de seguir
        followingList.remove(userId);
        _users[userIndex] = _users[userIndex].copyWith(
          isFollowing: false,
          followersCount: _users[userIndex].followersCount - 1,
        );
      } else {
        // Seguir
        followingList.add(userId);
        _users[userIndex] = _users[userIndex].copyWith(
          isFollowing: true,
          followersCount: _users[userIndex].followersCount + 1,
        );
      }
      notifyListeners();
    }
  }

  List<User> getFollowingUsers() {
    final followingIds = _followingMap[_currentUserId] ?? [];
    return _users.where((user) => followingIds.contains(user.id)).toList();
  }

  List<User> getFollowers() {
    return _users.where((user) {
      final userFollowingList = _followingMap[user.id] ?? [];
      return userFollowingList.contains(_currentUserId);
    }).toList();
  }

  List<User> getFollowersForUser(String userId) {
    return _users.where((user) {
      final userFollowingList = _followingMap[user.id] ?? [];
      return userFollowingList.contains(userId);
    }).toList();
  }

  List<User> getFollowingForUser(String userId) {
    final followingIds = _followingMap[userId] ?? [];
    return _users.where((user) => followingIds.contains(user.id)).toList();
  }
}
