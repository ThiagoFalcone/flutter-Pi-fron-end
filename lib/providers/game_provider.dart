// game_provider.dart
// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter_teste/repository/game_repository.dart';
import 'custom_change_notifier.dart';
import '../models/game_model.dart';

class GameProvider extends CustomChangeNotifier {
  final GameRepository _gameRepository = GameRepository();
  final List<GameSave> _gameSaves = [];

  List<Game> get allGames => _gameRepository.allGames;
  List<Game> get myGames => _gameRepository.myGames;
  List<GameSave> get gameSaves => _gameSaves;

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
    final save = _gameSaves.firstWhere((s) => s.id == saveId);
    _gameSaves.removeWhere((save) => save.id == saveId);
    _updateTotalPlaytime(save.gameId);
    notifyListeners();
    _saveSavesToLocal();
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
}
