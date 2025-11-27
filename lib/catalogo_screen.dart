import 'package:flutter/material.dart';
import 'game_model.dart';
import 'game_details_screen.dart';
import 'my_games_screen.dart';
import 'profile_screen.dart';

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
      MaterialPageRoute(builder: (context) => GameDetailsScreen(game: game)),
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

  void _addToMyGames(Game game) {
    _showSnackBar('${game.title} adicionado à sua lista!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF667EEA),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'Catálogo de Jogos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: _navigateToProfile,
            tooltip: 'Perfil',
          ),
          IconButton(
            icon: const Icon(Icons.collections_bookmark, color: Colors.white),
            onPressed: _navigateToMyGames,
            tooltip: 'Meus Jogos',
          ),
        ],
      ),
      body: Column(
        children: [
          // BARRA DE PESQUISA
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
                      fillColor: const Color(0xFF1A1A2E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                // BOTÃO FILTRO
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF667EEA),
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Color(0xFF667EEA),
                    ),
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
                      });
                    },
                    child: const Text(
                      'Limpar tudo',
                      style: TextStyle(color: Color(0xFF667EEA), fontSize: 12),
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
                    color: const Color(0xFF2A2A3E),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${_filteredGames.length} jogos encontrados',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // LISTA DE JOGOS
          Expanded(
            child: _filteredGames.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Nenhum jogo encontrado',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tente ajustar os filtros ou a busca',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredGames.length,
                    itemBuilder: (context, index) {
                      final game = _filteredGames[index];
                      return _buildGameCard(game);
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
        backgroundColor: const Color(0xFF667EEA),
        deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white),
        onDeleted: onRemove,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildGameCard(Game game) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _navigateToGameDetails(game),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CAPA DO JOGO COM TRATAMENTO DE ERRO
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF2A2A3E),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    game.coverUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF2A2A3E),
                        child: const Icon(
                          Icons.gamepad,
                          color: Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFF2A2A3E),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF667EEA),
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
                    Text(
                      game.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          game.rating.toString(),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          game.price == 0
                              ? 'Gratuito'
                              : 'R\$${game.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: game.price == 0
                                ? Colors.green
                                : Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // BOTÃO ADICIONAR
              IconButton(
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF667EEA),
                  size: 28,
                ),
                onPressed: () => _addToMyGames(game),
                tooltip: 'Adicionar à lista',
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
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 10),
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

class FilterModalContent extends StatefulWidget {
  final String selectedCategory;
  final String selectedPlatform;
  final List<String> categories;
  final List<String> platforms;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onPlatformChanged;
  final VoidCallback onClearFilters;
  final VoidCallback onApplyFilters;

  const FilterModalContent({
    super.key,
    required this.selectedCategory,
    required this.selectedPlatform,
    required this.categories,
    required this.platforms,
    required this.onCategoryChanged,
    required this.onPlatformChanged,
    required this.onClearFilters,
    required this.onApplyFilters,
  });

  @override
  State<FilterModalContent> createState() => _FilterModalContentState();
}

class _FilterModalContentState extends State<FilterModalContent> {
  late String _tempCategory;
  late String _tempPlatform;

  @override
  void initState() {
    super.initState();
    _tempCategory = widget.selectedCategory;
    _tempPlatform = widget.selectedPlatform;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CABEÇALHO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtros',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // FILTRO DE CATEGORIA
          _buildFilterSection(
            'Categoria',
            Icons.category,
            widget.categories,
            _tempCategory,
            (value) {
              setState(() {
                _tempCategory = value;
              });
            },
          ),

          const SizedBox(height: 24),

          // FILTRO DE PLATAFORMA
          _buildFilterSection(
            'Plataforma',
            Icons.computer,
            widget.platforms,
            _tempPlatform,
            (value) {
              setState(() {
                _tempPlatform = value;
              });
            },
          ),

          const SizedBox(height: 32),

          // BOTÕES
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _tempCategory = 'Todos';
                      _tempPlatform = 'Todas';
                    });
                    widget.onClearFilters();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF667EEA),
                    side: const BorderSide(color: Color(0xFF667EEA)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Limpar Filtros'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onCategoryChanged(_tempCategory);
                    widget.onPlatformChanged(_tempPlatform);
                    widget.onApplyFilters();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF667EEA),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Aplicar Filtros'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    IconData icon,
    List<String> options,
    String selectedValue,
    ValueChanged<String> onSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF667EEA), size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return ChoiceChip(
              label: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                onSelected(option);
              },
              backgroundColor: const Color(0xFF2A2A3E),
              selectedColor: const Color(0xFF667EEA),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          }).toList(),
        ),
      ],
    );
  }
}
