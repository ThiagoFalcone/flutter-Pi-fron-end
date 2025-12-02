// screens/catalogo_screen.dart
// ignore_for_file: unused_element, avoid_print, deprecated_member_use, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_teste/models/filter_modal_content.dart'
    show FilterModalContent;
import 'package:flutter_teste/screen/my_games_screen.dart' show MyGamesScreen;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_model.dart';
import 'package:flutter_teste/screen/game_details_screen.dart';
import 'package:flutter_teste/screen/profile_screen.dart';
import 'package:flutter_teste/screen/opinion_screen.dart';
import 'package:flutter_teste/screen/opinion_editor_screen.dart';

class GamesCatalogScreen extends StatefulWidget {
  const GamesCatalogScreen({super.key});

  @override
  State<GamesCatalogScreen> createState() => _GamesCatalogScreenState();
}

class _GamesCatalogScreenState extends State<GamesCatalogScreen> {
  final List<Game> _games = [
    Game(
      id: '1',
      title: 'The Witcher 3: Wild Hunt',
      developer: 'CD Projekt Red',
      publisher: 'CD Projekt',
      price: 79.90,
      rating: 4.9,
      coverUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8gE2Qf0z7ABPnQIB_cgs1XSOKuQ9Ely_VA3cCRZQTmvRI152ckfATCqQFo7cxVG7Lvi2dk3eR7RMoAxO7F6aa-rlnn9qj8g_-7bMwrtI&s=10',
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

  final List<String> _categories = [
    'Todos',
    'RPG',
    'Ação',
    'Aventura',
    'Simulação',
    'Metroidvania',
    'Roguelike',
    'Sandbox',
    'FPS',
    'Plataforma',
  ];

  final List<String> _platforms = [
    'Todas',
    'PC',
    'PlayStation',
    'Xbox',
    'Switch',
    'Mobile',
  ];

  String _selectedCategory = 'Todos';
  String _selectedPlatform = 'Todas';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Cache para estatísticas de opiniões
  final Map<String, Map<String, dynamic>> _gameStats = {};

  @override
  void initState() {
    super.initState();
    _loadOpinionsStats();
  }

  Future<void> _loadOpinionsStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedOpinions = prefs.getString('userOpinions');

      if (savedOpinions != null) {
        final List<dynamic> opinionsData = json.decode(savedOpinions);

        // Calcular estatísticas por jogo
        for (var opinionData in opinionsData) {
          final gameId = opinionData['gameId']?.toString() ?? '';
          final rating = (opinionData['rating'] as num?)?.toDouble() ?? 0.0;
          final recommended = opinionData['recommended'] == true;

          if (!_gameStats.containsKey(gameId)) {
            _gameStats[gameId] = {
              'count': 0,
              'totalRating': 0.0,
              'recommendedCount': 0,
              'averageRating': 0.0,
              'recommendationRate': 0.0,
            };
          }

          _gameStats[gameId]!['count'] =
              (_gameStats[gameId]!['count'] as int) + 1;
          _gameStats[gameId]!['totalRating'] =
              (_gameStats[gameId]!['totalRating'] as double) + rating;
          if (recommended) {
            _gameStats[gameId]!['recommendedCount'] =
                (_gameStats[gameId]!['recommendedCount'] as int) + 1;
          }

          // Calcular médias
          final count = _gameStats[gameId]!['count'] as int;
          final totalRating = _gameStats[gameId]!['totalRating'] as double;
          final recommendedCount =
              _gameStats[gameId]!['recommendedCount'] as int;

          _gameStats[gameId]!['averageRating'] = count > 0
              ? totalRating / count
              : 0.0;
          _gameStats[gameId]!['recommendationRate'] = count > 0
              ? (recommendedCount / count) * 100
              : 0.0;
        }

        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print('Erro ao carregar estatísticas de opiniões: $e');
    }
  }

  List<Game> get _filteredGames {
    return _games.where((game) {
      final categoryMatch =
          _selectedCategory == 'Todos' || game.category == _selectedCategory;
      final platformMatch =
          _selectedPlatform == 'Todas' ||
          game.platforms.contains(_selectedPlatform);
      final searchMatch =
          _searchQuery.isEmpty ||
          game.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          game.developer.toLowerCase().contains(_searchQuery.toLowerCase());

      return categoryMatch && platformMatch && searchMatch;
    }).toList();
  }

  void _navigateToGameDetails(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailsScreen(
          game: game,
          opinionsCount: _gameStats[game.id]?['count'] ?? 0,
          averageRating: _gameStats[game.id]?['averageRating'] ?? 0.0,
          recommendationRate: _gameStats[game.id]?['recommendationRate'] ?? 0.0,
        ),
      ),
    );
  }

  void _navigateToMyGames() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyGamesScreen()),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  void _navigateToOpinions(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OpinionScreen(game: game)),
    ).then((_) {
      _loadOpinionsStats();
    });
  }

  void _navigateToAllOpinions() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OpinionScreen()),
    );
  }

  void _createOpinionForGame(Game game) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OpinionEditorScreen(gameId: game.id, gameTitle: game.title),
      ),
    );

    if (result != null && result is bool && result) {
      _showSnackBar('✅ Opinião criada com sucesso!');
      _loadOpinionsStats();
    }
  }

  void _addToMyGames(Game game) {
    _showSnackBar('🎮 ${game.title} adicionado à sua lista!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return FilterModalContent(
          selectedCategory: _selectedCategory,
          selectedPlatform: _selectedPlatform,
          categories: _categories,
          platforms: _platforms,
          onCategoryChanged: (category) {
            setState(() {
              _selectedCategory = category;
            });
          },
          onPlatformChanged: (platform) {
            setState(() {
              _selectedPlatform = platform;
            });
          },
          onClearFilters: () {
            setState(() {
              _selectedCategory = 'Todos';
              _selectedPlatform = 'Todas';
            });
            Navigator.pop(context);
          },
          onApplyFilters: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Map<String, dynamic>? _getGameStats(String gameId) {
    return _gameStats[gameId];
  }

  int _getOpinionsCount(String gameId) {
    return _gameStats[gameId]?['count'] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Catálogo de Jogos',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.reviews_outlined, color: Colors.purple),
            onPressed: _navigateToAllOpinions,
            tooltip: 'Ver todas as opiniões',
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black54),
            onPressed: _navigateToProfile,
            tooltip: 'Perfil',
          ),
          IconButton(
            icon: const Icon(
              Icons.collections_bookmark_outlined,
              color: Colors.black54,
            ),
            onPressed: _navigateToMyGames,
            tooltip: 'Meus Jogos',
          ),
        ],
      ),
      body: Column(
        children: [
          // BARRA DE PESQUISA COM FILTRO
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Pesquisar jogos...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                    ),
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
                const SizedBox(width: 12),
                // BOTÃO FILTRO
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.black54),
                    onPressed: _showFilterModal,
                    tooltip: 'Filtros',
                  ),
                ),
              ],
            ),
          ),

          // INDICADORES DE FILTRO ATIVO
          if (_selectedCategory != 'Todos' || _selectedPlatform != 'Todas')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  if (_selectedCategory != 'Todos')
                    _buildActiveFilterChip(
                      'Categoria: $_selectedCategory',
                      onRemove: () {
                        setState(() {
                          _selectedCategory = 'Todos';
                        });
                      },
                    ),
                  if (_selectedPlatform != 'Todas')
                    _buildActiveFilterChip(
                      'Plataforma: $_selectedPlatform',
                      onRemove: () {
                        setState(() {
                          _selectedPlatform = 'Todas';
                        });
                      },
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'Todos';
                        _selectedPlatform = 'Todas';
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                    child: const Text(
                      'Limpar tudo',
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 8),

          // CONTADOR DE JOGOS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.games, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        '${_filteredGames.length} jogos',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 8),
                      const Icon(Icons.reviews, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        '${_gameStats.length} com opiniões',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // LISTA DE JOGOS
          Expanded(
            child: _filteredGames.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Nenhum jogo encontrado',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tente ajustar os filtros ou a busca',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredGames.length,
                    itemBuilder: (context, index) {
                      final game = _filteredGames[index];
                      final gameStats = _getGameStats(game.id);
                      final opinionsCount = gameStats?['count'] ?? 0;

                      return _buildGameCard(game, opinionsCount, gameStats);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFilterChip(
    String label, {
    required VoidCallback onRemove,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        backgroundColor: Colors.blue,
        deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white),
        onDeleted: onRemove,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildGameCard(
    Game game,
    int opinionsCount,
    Map<String, dynamic>? gameStats,
  ) {
    final averageRating = gameStats?['averageRating'] ?? 0.0;
    final recommendationRate = gameStats?['recommendationRate'] ?? 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.grey, width: 0.1),
      ),
      child: InkWell(
        onTap: () => _navigateToGameDetails(game),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CAPA DO JOGO
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    game.coverUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[100],
                        child: const Icon(
                          Icons.games_outlined,
                          color: Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[100],
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // INFORMAÇÕES DO JOGO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            game.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (opinionsCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.purple.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.reviews,
                                  size: 12,
                                  color: Colors.purple,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '$opinionsCount',
                                  style: const TextStyle(
                                    color: Colors.purple,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      game.developer,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _buildInfoChip(game.category),
                        _buildInfoChip('${game.releaseYear}'),
                        _buildInfoChip(_formatPlatforms(game.platforms)),
                      ],
                    ),

                    // ESTATÍSTICAS DE OPINIÕES
                    if (opinionsCount > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            // Rating médio
                            _buildStatsChip(
                              Icons.star,
                              averageRating.toStringAsFixed(1),
                              Colors.amber,
                            ),
                            const SizedBox(width: 8),

                            // Taxa de recomendação
                            _buildStatsChip(
                              Icons.thumb_up,
                              '${recommendationRate.toStringAsFixed(0)}%',
                              Colors.green,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 12),

                    // BOTÕES DE AÇÃO
                    Row(
                      children: [
                        // Botão ver opiniões
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _navigateToOpinions(game),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.purple,
                              side: const BorderSide(color: Colors.purple),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.reviews, size: 16),
                            label: Text(
                              opinionsCount > 0
                                  ? 'Ver Opiniões'
                                  : 'Sem opiniões',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Botão dar opinião
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _createOpinionForGame(game),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.edit_note, size: 16),
                            label: const Text(
                              'Opinar',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // PREÇO
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          game.price == 0
                              ? 'Gratuito'
                              : 'R\$${game.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: game.price == 0
                                ? Colors.green
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // BOTÃO ADICIONAR À LISTA
              IconButton(
                icon: Icon(
                  game.isInLibrary
                      ? Icons.check_circle
                      : Icons.add_circle_outline,
                  color: game.isInLibrary ? Colors.green : Colors.blue,
                  size: 28,
                ),
                onPressed: () => _addToMyGames(game),
                tooltip: game.isInLibrary ? 'Já na lista' : 'Adicionar à lista',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[200]!, width: 0.5),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      ),
    );
  }

  Widget _buildStatsChip(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPlatforms(List<String> platforms) {
    if (platforms.length <= 2) {
      return platforms.join(', ');
    } else {
      return '${platforms.take(2).join(', ')}+${platforms.length - 2}';
    }
  }
}
