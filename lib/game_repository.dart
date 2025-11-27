// game_repository.dart
import 'game_model.dart';

class GameRepository {
  static final GameRepository _instance = GameRepository._internal();
  factory GameRepository() => _instance;
  GameRepository._internal();

  final List<Game> _allGames = [
    // Sua lista completa de jogos aqui (igual ao catálogo)
    Game(
      id: '1',
      title: 'The Witcher 3: Wild Hunt',
      developer: 'CD Projekt Red',
      publisher: 'CD Projekt',
      price: 79.90,
      rating: 4.9,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co2rry.jpg',
      description: 'RPG de mundo aberto em um universo de fantasia sombria.',
      category: 'RPG',
      platforms: ['PC', 'PlayStation', 'Xbox', 'Switch'],
      releaseYear: 2015,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    // ... outros jogos
  ];

  List<Game> get allGames => _allGames;

  List<Game> get myGames =>
      _allGames.where((game) => game.isInLibrary).toList();

  void addToLibrary(String gameId) {
    final game = _allGames.firstWhere((g) => g.id == gameId);
    final index = _allGames.indexOf(game);
    _allGames[index] = game.copyWith(isInLibrary: true);
  }

  void removeFromLibrary(String gameId) {
    final game = _allGames.firstWhere((g) => g.id == gameId);
    final index = _allGames.indexOf(game);
    _allGames[index] = game.copyWith(isInLibrary: false);
  }

  void toggleLibraryStatus(String gameId) {
    final game = _allGames.firstWhere((g) => g.id == gameId);
    final index = _allGames.indexOf(game);
    _allGames[index] = game.copyWith(isInLibrary: !game.isInLibrary);
  }
}
