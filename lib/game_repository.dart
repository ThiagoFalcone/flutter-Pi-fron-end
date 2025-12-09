// game_repository.dart
import 'game_model.dart';

// Importar o enum GameStatus

class GameRepository {
  static final GameRepository _instance = GameRepository._internal();
  factory GameRepository() => _instance;
  GameRepository._internal();

  final List<Game> _allGames = [
    Game(
      id: '1',
      title: 'The Witcher 3: Wild Hunt',
      developer: 'CD Projekt Red',
      publisher: 'CD Projekt',
      price: 79.90,
      rating: 4.9,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co1xrx.jpg',
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
    Game(
      id: '2',
      title: 'Cyberpunk 2077',
      developer: 'CD Projekt Red',
      publisher: 'CD Projekt',
      price: 129.90,
      rating: 4.2,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/coaih8.jpg',
      description: 'RPG de ação em um futuro distópico.',
      category: 'RPG',
      platforms: ['PC', 'PlayStation', 'Xbox'],
      releaseYear: 2020,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '3',
      title: 'Red Dead Redemption 2',
      developer: 'Rockstar Games',
      publisher: 'Rockstar Games',
      price: 149.90,
      rating: 4.8,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co1q1f.jpg',
      description: 'Aventura no velho oeste americano.',
      category: 'Aventura',
      platforms: ['PC', 'PlayStation', 'Xbox'],
      releaseYear: 2018,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '4',
      title: 'God of War Ragnarök',
      developer: 'Santa Monica Studio',
      publisher: 'Sony Interactive Entertainment',
      price: 249.90,
      rating: 4.9,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co5s5v.webp',
      description: 'Sequência da jornada de Kratos e Atreus.',
      category: 'Ação',
      platforms: ['PlayStation'],
      releaseYear: 2022,
      platform: 'PlayStation',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '5',
      title: 'The Last of Us Part II',
      developer: 'Naughty Dog',
      publisher: 'Sony Interactive Entertainment',
      price: 199.90,
      rating: 4.7,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co5ziw.webp',
      description: 'Sobrevivência em um mundo pós-apocalíptico.',
      category: 'Ação',
      platforms: ['PlayStation', 'PC'],
      releaseYear: 2020,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '6',
      title: 'Hollow Knight',
      developer: 'Team Cherry',
      publisher: 'Team Cherry',
      price: 29.90,
      rating: 4.8,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co93cr.webp',
      description: 'Aventura de ação em um reino de insetos.',
      category: 'Metroidvania',
      platforms: ['PC', 'PlayStation', 'Xbox', 'Switch'],
      releaseYear: 2017,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '7',
      title: 'Stardew Valley',
      developer: 'ConcernedApe',
      publisher: 'ConcernedApe',
      price: 24.90,
      rating: 4.9,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/coa93h.webp',
      description: 'Simulação de fazenda e vida rural.',
      category: 'Simulação',
      platforms: ['PC', 'PlayStation', 'Xbox', 'Switch', 'Mobile'],
      releaseYear: 2016,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '8',
      title: 'Hades',
      developer: 'Supergiant Games',
      publisher: 'Supergiant Games',
      price: 49.90,
      rating: 4.9,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co39vc.webp',
      description: 'Roguelike de ação no submundo grego.',
      category: 'Roguelike',
      platforms: ['PC', 'PlayStation', 'Xbox', 'Switch'],
      releaseYear: 2020,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '9',
      title: 'Elden Ring',
      developer: 'FromSoftware',
      publisher: 'Bandai Namco',
      price: 199.90,
      rating: 4.9,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co3p2d.jpg',
      description: 'RPG de ação em mundo aberto pelos criadores de Dark Souls.',
      category: 'RPG',
      platforms: ['PC', 'PlayStation', 'Xbox'],
      releaseYear: 2022,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '10',
      title: 'Minecraft',
      developer: 'Mojang Studios',
      publisher: 'Mojang Studios',
      price: 89.90,
      rating: 4.8,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co8fu7.webp',
      description: 'Jogo sandbox de construção e aventura.',
      category: 'Sandbox',
      platforms: ['PC', 'PlayStation', 'Xbox', 'Switch', 'Mobile'],
      releaseYear: 2011,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '11',
      title: 'Grand Theft Auto V',
      developer: 'Rockstar Games',
      publisher: 'Rockstar Games',
      price: 99.90,
      rating: 4.7,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co9751.webp',
      description: 'Mundo aberto de ação e aventura.',
      category: 'Ação',
      platforms: ['PC', 'PlayStation', 'Xbox'],
      releaseYear: 2013,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '12',
      title: 'The Legend of Zelda: Breath of the Wild',
      developer: 'Nintendo',
      publisher: 'Nintendo',
      price: 299.90,
      rating: 4.9,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co31di.webp',
      description: 'Aventura épica no reino de Hyrule.',
      category: 'Aventura',
      platforms: ['Switch'],
      releaseYear: 2017,
      platform: 'Switch',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '13',
      title: 'Counter-Strike 2',
      developer: 'Valve',
      publisher: 'Valve',
      price: 0.00,
      rating: 4.5,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/coaczd.webp',
      description: 'FPS tático competitivo.',
      category: 'FPS',
      platforms: ['PC'],
      releaseYear: 2023,
      platform: 'PC',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '14',
      title: 'Dead Cells',
      developer: 'Motion Twin',
      publisher: 'Motion Twin',
      price: 37.90,
      rating: 4.6,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co7jfv.webp',
      description: 'Roguelike de ação com combate rápido.',
      category: 'Roguelike',
      platforms: ['PC', 'PlayStation', 'Xbox', 'Switch', 'Mobile'],
      releaseYear: 2018,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
    Game(
      id: '15',
      title: 'Celeste',
      developer: 'Maddy Makes Games',
      publisher: 'Maddy Makes Games',
      price: 42.90,
      rating: 4.7,
      coverUrl:
          'https://images.igdb.com/igdb/image/upload/t_cover_big/co3byy.webp',
      description: 'Plataforma desafiadora com história emocionante.',
      category: 'Plataforma',
      platforms: ['PC', 'PlayStation', 'Xbox', 'Switch'],
      releaseYear: 2018,
      platform: 'Multiplataforma',
      isInLibrary: false,
      isCompleted: false,
      completionDate: null,
      playtime: 0,
    ),
  ];

  List<Game> get allGames => _allGames;

  List<Game> get myGames =>
      _allGames.where((game) => game.isInLibrary).toList();

  void addToLibrary(String gameId) {
    try {
      final game = _allGames.firstWhere((g) => g.id == gameId);
      final index = _allGames.indexOf(game);
      _allGames[index] = game.copyWith(isInLibrary: true);
    } catch (e) {
      print('Erro ao adicionar jogo à biblioteca: $e');
    }
  }

  void removeFromLibrary(String gameId) {
    try {
      final game = _allGames.firstWhere((g) => g.id == gameId);
      final index = _allGames.indexOf(game);
      _allGames[index] = game.copyWith(isInLibrary: false);
    } catch (e) {
      print('Erro ao remover jogo da biblioteca: $e');
    }
  }

  void toggleLibraryStatus(String gameId) {
    try {
      final game = _allGames.firstWhere((g) => g.id == gameId);
      final index = _allGames.indexOf(game);
      _allGames[index] = game.copyWith(isInLibrary: !game.isInLibrary);
    } catch (e) {
      print('Erro ao alternar status da biblioteca: $e');
    }
  }

  void updateGameStatus(String gameId, GameStatus status) {
    try {
      final game = _allGames.firstWhere((g) => g.id == gameId);
      final index = _allGames.indexOf(game);
      _allGames[index] = game.copyWith(gameStatus: status);
      
      // Se o status for "Completado", marcar como completado também
      if (status == GameStatus.completed) {
        _allGames[index] = _allGames[index].copyWith(
          isCompleted: true,
          completionDate: DateTime.now(),
        );
      } else if (status != GameStatus.completed && _allGames[index].isCompleted) {
        // Se mudar de completado para outro status, manter isCompleted mas pode limpar completionDate
        // Ou você pode decidir manter o histórico
      }
    } catch (e) {
      print('Erro ao atualizar status do jogo: $e');
    }
  }
}
