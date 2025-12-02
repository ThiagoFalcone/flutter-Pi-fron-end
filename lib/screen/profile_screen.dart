// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_teste/models/share_option.dart' show ShareOption;
import 'package:flutter_teste/models/user_profile.dart' show UserProfile;
import 'package:flutter_teste/models/user_status.dart' show UserStatus;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _userProfile;
  final TextEditingController _steamController = TextEditingController();
  final TextEditingController _psnController = TextEditingController();
  final TextEditingController _xboxController = TextEditingController();
  final TextEditingController _nintendoController = TextEditingController();

  // Flag para controle de carregamento
  bool _isLoading = true;

  // Cores clean - paleta suave
  final Color _backgroundColor = const Color(0xFFF8FAFC);
  final Color _surfaceColor = Colors.white;
  final Color _primaryColor = const Color(0xFF4F46E5);
  final Color _secondaryColor = const Color(0xFF10B981);
  final Color _textPrimary = const Color(0xFF1E293B);
  final Color _textSecondary = const Color(0xFF64748B);
  final Color _borderColor = const Color(0xFFE2E8F0);

  // URLs das logos das plataformas
  final Map<String, String> _platformLogos = {
    'steam':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Steam_icon_logo.svg/512px-Steam_icon_logo.svg.png',
    'psn':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Playstation_logo_colour.svg/512px-Playstation_logo_colour.svg.png',
    'xbox':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Xbox_one_logo.svg/512px-Xbox_one_logo.svg.png',
    'nintendo':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Nintendo.svg/512px-Nintendo.svg.png',
  };

  // Opções de status
  final List<UserStatus> _statusOptions = [
    UserStatus('Online', Icons.circle, Color(0xFF10B981)),
    UserStatus('Ocupado', Icons.remove_circle, Color(0xFFF59E0B)),
    UserStatus('Ausente', Icons.timer, Color(0xFF6366F1)),
    UserStatus('Offline', Icons.circle_outlined, Color(0xFF94A3B8)),
    UserStatus('Jogando', Icons.sports_esports, Color(0xFF8B5CF6)),
    UserStatus('Não perturbe', Icons.do_not_disturb, Color(0xFFEF4444)),
  ];

  // Opções de compartilhamento
  final List<ShareOption> _shareOptions = [
    ShareOption(
      'WhatsApp',
      Icons.chat,
      Color(0xFF25D366),
      'https://web.whatsapp.com/',
    ),
    ShareOption(
      'Facebook',
      Icons.facebook,
      Color(0xFF1877F2),
      'https://facebook.com/',
    ),
    ShareOption(
      'Instagram',
      Icons.camera_alt,
      Color(0xFFE4405F),
      'https://instagram.com/',
    ),
    ShareOption(
      'Discord',
      Icons.chat_bubble,
      Color(0xFF5865F2),
      'https://discord.com/',
    ),
    ShareOption(
      'Twitter',
      Icons.trending_up,
      Color(0xFF1DA1F2),
      'https://twitter.com/',
    ),
    ShareOption('Copiar Link', Icons.link, Color(0xFF64748B), null),
  ];

  UserStatus _selectedStatus = UserStatus(
    'Online',
    Icons.circle,
    Color(0xFF10B981),
  );

  // Controladores para edição de horas
  final Map<String, TextEditingController> _hoursControllers = {};

  // Lista de jogos removidos temporariamente
  final List<String> _removedGames = [];

  // IDs dos jogos completados (para persistência)
  final List<String> _completedGameIds = [];

  // Mapa para horas personalizadas por jogo
  final Map<String, int> _customGameHours = {};

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      // Carregar dados do usuário salvos
      final savedUsername = prefs.getString('username') ?? 'GameMaster';
      final savedEmail = prefs.getString('email') ?? 'gamer@example.com';
      final savedSteamId = prefs.getString('steamId');
      final savedPsnId = prefs.getString('psnId');
      final savedXboxId = prefs.getString('xboxId');
      final savedNintendoId = prefs.getString('nintendoId');
      final savedTotalPlaytime = prefs.getInt('totalPlaytime') ?? 0;
      final savedAvatarUrl =
          prefs.getString('avatarUrl') ??
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80';

      // Carregar lista de IDs de jogos completados
      final savedCompletedGameIds =
          prefs.getStringList('completedGameIds') ?? [];
      _completedGameIds.addAll(savedCompletedGameIds);

      // Carregar horas personalizadas para cada jogo
      final savedGameHours = prefs.getString('gameHours');
      if (savedGameHours != null) {
        final Map<String, dynamic> hoursData = json.decode(savedGameHours);
        hoursData.forEach((key, value) {
          _customGameHours[key] = value as int;
        });
      }

      // Carregar jogos removidos
      final savedRemovedGames = prefs.getStringList('removedGames') ?? [];
      _removedGames.addAll(savedRemovedGames);

      // Carregar status selecionado
      final savedStatusIndex = prefs.getInt('selectedStatus') ?? 0;
      if (savedStatusIndex < _statusOptions.length) {
        _selectedStatus = _statusOptions[savedStatusIndex];
      }

      // Carregar jogos completados
      List<Game> completedGames = [];

      if (_completedGameIds.isNotEmpty) {
        // Buscar jogos do armazenamento local ou cache
        for (var gameId in _completedGameIds) {
          final game = await _getGameFromCacheOrExample(gameId);
          if (game != null) {
            final savedHours = _customGameHours[gameId];
            final gameWithSavedData = game.copyWith(
              isCompleted: true,
              playtime: savedHours ?? game.playtime,
              completionDate: DateTime.now(),
            );
            completedGames.add(gameWithSavedData);

            // Inicializar controlador com horas salvas ou padrão
            _hoursControllers[gameId] = TextEditingController(
              text: (savedHours ?? game.playtime).toString(),
            );
          }
        }
      } else {
        // Se não houver jogos salvos, carregar dados de exemplo
        completedGames = _getExampleGames();
        for (var game in completedGames) {
          if (!_completedGameIds.contains(game.id)) {
            _completedGameIds.add(game.id);
          }
          _hoursControllers[game.id] = TextEditingController(
            text: game.playtime.toString(),
          );
        }
      }

      // Calcular total de horas
      final totalPlaytime = completedGames.fold(
        0,
        (sum, game) => sum + game.playtime,
      );

      // Criar perfil do usuário
      _userProfile = UserProfile(
        id: '1',
        username: savedUsername,
        email: savedEmail,
        steamId: savedSteamId,
        psnId: savedPsnId,
        xboxId: savedXboxId,
        nintendoId: savedNintendoId,
        completedGames: completedGames,
        totalPlaytime: totalPlaytime,
        avatarUrl: savedAvatarUrl,
      );

      // Inicializar controladores das plataformas
      _steamController.text = savedSteamId ?? '';
      _psnController.text = savedPsnId ?? '';
      _xboxController.text = savedXboxId ?? '';
      _nintendoController.text = savedNintendoId ?? '';
    } catch (e) {
      // Em caso de erro, carregar dados padrão
      print('Erro ao carregar perfil: $e');
      _initializeDefaultProfile();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Game?> _getGameFromCacheOrExample(String gameId) async {
    // Tenta buscar do armazenamento local primeiro
    final prefs = await SharedPreferences.getInstance();
    final savedGameData = prefs.getString('game_$gameId');

    if (savedGameData != null) {
      try {
        final gameData = json.decode(savedGameData);
        return Game.fromJson(gameData);
      } catch (e) {
        print('Erro ao decodificar jogo salvo: $e');
      }
    }

    // Se não encontrar no cache, usa dados de exemplo baseados no ID
    return _getExampleGameById(gameId);
  }

  Game? _getExampleGameById(String id) {
    // Mapa de jogos de exemplo
    final exampleGames = {
      '1': Game(
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
        isCompleted: true,
        completionDate: DateTime(2023, 10, 15),
        playtime: 120,
        platform: 'PC',
        isInLibrary: true,
      ),
      '7': Game(
        id: '7',
        title: 'Stardew Valley',
        developer: 'ConcernedApe',
        publisher: 'ConcernedApe',
        price: 24.90,
        rating: 4.9,
        coverUrl:
            'https://images.igdb.com/igdb/image/upload/t_cover_big/co2rrd.jpg',
        description: 'Simulação de fazenda e vida rural.',
        category: 'Simulação',
        platforms: ['PC', 'PlayStation', 'Xbox', 'Switch', 'Mobile'],
        releaseYear: 2016,
        isCompleted: true,
        completionDate: DateTime(2023, 8, 20),
        playtime: 85,
        platform: 'Switch',
        isInLibrary: true,
      ),
      '3': Game(
        id: '3',
        title: 'Hollow Knight',
        developer: 'Team Cherry',
        publisher: 'Team Cherry',
        price: 39.90,
        rating: 4.8,
        coverUrl:
            'https://images.igdb.com/igdb/image/upload/t_cover_big/co1r7a.jpg',
        description: 'Ação e aventura em um reino de insetos em ruínas.',
        category: 'Metroidvania',
        platforms: ['PC', 'PlayStation', 'Xbox', 'Switch'],
        releaseYear: 2017,
        isCompleted: true,
        completionDate: DateTime(2023, 5, 10),
        playtime: 45,
        platform: 'Switch',
        isInLibrary: true,
      ),
      '4': Game(
        id: '4',
        title: 'Elden Ring',
        developer: 'FromSoftware',
        publisher: 'Bandai Namco',
        price: 249.90,
        rating: 4.9,
        coverUrl:
            'https://images.igdb.com/igdb/image/upload/t_cover_big/co5a5d.jpg',
        description:
            'RPG de ação em mundo aberto ambientado em um universo de fantasia sombria.',
        category: 'RPG',
        platforms: ['PC', 'PlayStation', 'Xbox'],
        releaseYear: 2022,
        isCompleted: false,
        completionDate: null,
        playtime: 0,
        platform: 'PC',
        isInLibrary: true,
      ),
      '5': Game(
        id: '5',
        title: 'God of War Ragnarök',
        developer: 'Santa Monica Studio',
        publisher: 'Sony Interactive Entertainment',
        price: 299.90,
        rating: 4.8,
        coverUrl:
            'https://images.igdb.com/igdb/image/upload/t_cover_big/co5wyg.jpg',
        description: 'Aventura épica na mitologia nórdica.',
        category: 'Ação e Aventura',
        platforms: ['PlayStation'],
        releaseYear: 2022,
        isCompleted: false,
        completionDate: null,
        playtime: 0,
        platform: 'PlayStation',
        isInLibrary: true,
      ),
    };

    return exampleGames[id];
  }

  List<Game> _getExampleGames() {
    return [
      _getExampleGameById('1')!,
      _getExampleGameById('7')!,
      _getExampleGameById('3')!,
    ];
  }

  void _initializeDefaultProfile() {
    final completedGames = _getExampleGames();

    // Calcular total de horas
    final totalPlaytime = completedGames.fold(
      0,
      (sum, game) => sum + game.playtime,
    );

    _userProfile = UserProfile(
      id: '1',
      username: 'GameMaster',
      email: 'gamer@example.com',
      steamId: 'STEAM_0:1:12345678',
      psnId: 'PSN_GameMaster',
      xboxId: 'XboxGameMaster#1234',
      nintendoId: 'SW-1234-5678-9012',
      completedGames: completedGames,
      totalPlaytime: totalPlaytime,
      avatarUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
    );

    // Inicializar controladores para cada jogo
    for (var game in _userProfile.completedGames) {
      _hoursControllers[game.id] = TextEditingController(
        text: game.playtime.toString(),
      );
      if (!_completedGameIds.contains(game.id)) {
        _completedGameIds.add(game.id);
      }
    }

    _steamController.text = _userProfile.steamId ?? '';
    _psnController.text = _userProfile.psnId ?? '';
    _xboxController.text = _userProfile.xboxId ?? '';
    _nintendoController.text = _userProfile.nintendoId ?? '';
  }

  Future<void> _saveProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Salvar IDs das plataformas
      await prefs.setString('steamId', _steamController.text);
      await prefs.setString('psnId', _psnController.text);
      await prefs.setString('xboxId', _xboxController.text);
      await prefs.setString('nintendoId', _nintendoController.text);

      // Salvar status selecionado
      final statusIndex = _statusOptions.indexOf(_selectedStatus);
      await prefs.setInt('selectedStatus', statusIndex);

      // Atualizar perfil local
      setState(() {
        _userProfile = _userProfile.copyWith(
          steamId: _steamController.text.isNotEmpty
              ? _steamController.text
              : null,
          psnId: _psnController.text.isNotEmpty ? _psnController.text : null,
          xboxId: _xboxController.text.isNotEmpty ? _xboxController.text : null,
          nintendoId: _nintendoController.text.isNotEmpty
              ? _nintendoController.text
              : null,
        );
      });

      // Salvar total de horas
      await prefs.setInt('totalPlaytime', _userProfile.totalPlaytime);

      _showSnackBar('Perfil atualizado com sucesso!');
    } catch (e) {
      _showSnackBar('Erro ao salvar perfil: $e');
    }
  }

  Future<void> _saveGameChanges() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Salvar horas personalizadas de cada jogo
      _customGameHours.clear();
      for (var game in _userProfile.completedGames) {
        _customGameHours[game.id] = game.playtime;
      }
      await prefs.setString('gameHours', json.encode(_customGameHours));

      // Salvar lista de jogos completados
      await prefs.setStringList('completedGameIds', _completedGameIds);

      // Salvar jogos removidos
      await prefs.setStringList('removedGames', _removedGames);

      // Salvar total de horas atualizado
      await prefs.setInt('totalPlaytime', _userProfile.totalPlaytime);

      // Salvar dados dos jogos individualmente
      for (var game in _userProfile.completedGames) {
        await prefs.setString('game_${game.id}', json.encode(game.toJson()));
      }
    } catch (e) {
      print('Erro ao salvar alterações dos jogos: $e');
    }
  }

  void _updateGameHours(String gameId, String hoursText) async {
    final hours = int.tryParse(hoursText) ?? 0;
    setState(() {
      // Atualizar horas do jogo específico
      final updatedGames = _userProfile.completedGames.map((game) {
        if (game.id == gameId) {
          return game.copyWith(playtime: hours);
        }
        return game;
      }).toList();

      // Calcular novo total de horas
      final totalPlaytime = updatedGames.fold(
        0,
        (sum, game) => sum + game.playtime,
      );

      // Atualizar o perfil completo
      _userProfile = _userProfile.copyWith(
        completedGames: updatedGames,
        totalPlaytime: totalPlaytime,
      );

      // Atualizar o controlador também
      _hoursControllers[gameId]?.text = hours.toString();
    });

    // Salvar alterações persistentemente
    await _saveGameChanges();

    _showSnackBar('Horas atualizadas para $hours h');
  }

  void _removeGame(String gameId) async {
    setState(() {
      // Adicionar à lista de jogos removidos
      _removedGames.add(gameId);

      // Remover das horas controllers
      _hoursControllers.remove(gameId);

      // Mostrar mensagem de confirmação
      _showSnackBar('Jogo removido da lista de completados');
    });

    // Salvar alterações persistentemente
    await _saveGameChanges();
  }

  void _restoreGame(Game game) async {
    setState(() {
      // Remover da lista de removidos
      _removedGames.remove(game.id);

      // Adicionar de volta ao controlador de horas
      _hoursControllers[game.id] = TextEditingController(
        text: game.playtime.toString(),
      );

      _showSnackBar('Jogo restaurado com sucesso');
    });

    // Salvar alterações persistentemente
    await _saveGameChanges();
  }

  // Método para obter jogos visíveis (excluindo os removidos)
  List<Game> get _visibleCompletedGames {
    return _userProfile.completedGames
        .where((game) => !_removedGames.contains(game.id))
        .toList();
  }

  void _showEditHoursDialog(Game game) {
    final controller = TextEditingController(text: game.playtime.toString());

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: _surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _borderColor, width: 1),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.timer, color: _primaryColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Editar Horas',
                          style: TextStyle(
                            color: _textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          game.title,
                          style: TextStyle(color: _textSecondary, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // CAMPO DE HORAS
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Horas Jogadas',
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: _surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _borderColor, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        suffixText: 'horas',
                        suffixStyle: TextStyle(
                          color: _textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Digite o número total de horas jogadas',
                    style: TextStyle(
                      color: _textSecondary.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // BOTÕES
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _textSecondary,
                        side: BorderSide(color: _borderColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: _surfaceColor,
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final hours =
                            int.tryParse(controller.text) ?? game.playtime;
                        _updateGameHours(game.id, hours.toString());
                        Navigator.pop(context);
                        _showSnackBar(
                          '✅ Horas de ${game.title} atualizadas para $hours h',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGameOptionsDialog(Game game) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: _borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Opções do Jogo',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Opção de editar horas
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.timer, color: _primaryColor),
                ),
                title: Text(
                  'Editar Horas Jogadas',
                  style: TextStyle(color: _textPrimary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showEditHoursDialog(game);
                },
              ),

              // Opção de remover jogo
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
                title: Text(
                  'Remover da Lista',
                  style: TextStyle(color: _textPrimary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showRemoveConfirmationDialog(game);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRemoveConfirmationDialog(Game game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _borderColor, width: 1),
        ),
        title: Text(
          'Remover Jogo',
          style: TextStyle(color: _textPrimary, fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Tem certeza que deseja remover "${game.title}" da sua lista de jogos completados?',
          style: TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () {
              _removeGame(game.id);
              Navigator.pop(context);
            },
            child: Text('Remover', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showRemovedGamesDialog() {
    final removedGames = _userProfile.completedGames
        .where((game) => _removedGames.contains(game.id))
        .toList();

    if (removedGames.isEmpty) {
      _showSnackBar('Nenhum jogo removido para restaurar');
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: _surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: _borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Jogos Removidos',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF59E0B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      removedGames.length.toString(),
                      style: TextStyle(
                        color: Color(0xFFF59E0B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: removedGames.length,
                  itemBuilder: (context, index) {
                    final game = removedGames[index];
                    return _buildRemovedGameItem(game);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRemovedGameItem(Game game) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: NetworkImage(game.coverUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          game.title,
          style: TextStyle(color: _textPrimary, fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${game.playtime}h jogadas • ${game.platform}',
          style: TextStyle(color: _textSecondary, fontSize: 12),
        ),
        trailing: IconButton(
          icon: Icon(Icons.restore, color: _secondaryColor),
          onPressed: () => _restoreGame(game),
        ),
      ),
    );
  }

  void _showShareMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compartilhar Perfil',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Compartilhe seu perfil de jogador nas redes sociais',
                style: TextStyle(color: _textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: _shareOptions.length,
                itemBuilder: (context, index) {
                  return _buildShareOption(_shareOptions[index]);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareOption(ShareOption option) {
    return GestureDetector(
      onTap: () => _handleShare(option),
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: option.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(option.icon, color: option.color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              option.name,
              style: TextStyle(
                color: _textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleShare(ShareOption option) {
    Navigator.pop(context);

    final profileUrl =
        'https://gametracker.com/profile/${_userProfile.username}';
    final message =
        'Confira meu perfil de jogador: ${_userProfile.username}\n'
        '🎮 ${_visibleCompletedGames.length} jogos completados\n'
        '⏰ ${_userProfile.totalPlaytime}h jogadas\n'
        '📧 ${_userProfile.email}\n\n'
        'Link: $profileUrl';

    if (option.name == 'Copiar Link') {
      _showSnackBar('Link do perfil copiado!');
    } else {
      _showSnackBar('Compartilhando via ${option.name}...');
    }

    Future.delayed(const Duration(milliseconds: 1500), () {
      _showSnackBar('Perfil compartilhado no ${option.name}!');
    });
  }

  void _showStatusSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecionar Status',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              ..._statusOptions.map((status) => _buildStatusOption(status)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusOption(UserStatus status) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: status.color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(status.icon, color: status.color),
      ),
      title: Text(status.name, style: TextStyle(color: _textPrimary)),
      trailing: _selectedStatus.name == status.name
          ? Icon(Icons.check, color: _primaryColor)
          : null,
      onTap: () {
        setState(() {
          _selectedStatus = status;
        });
        Navigator.pop(context);
        _saveStatus();
        _showSnackBar('Status alterado para: ${status.name}');
      },
      contentPadding: EdgeInsets.zero,
    );
  }

  Future<void> _saveStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final statusIndex = _statusOptions.indexOf(_selectedStatus);
      await prefs.setInt('selectedStatus', statusIndex);
    } catch (e) {
      print('Erro ao salvar status: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose dos controladores
    _steamController.dispose();
    _psnController.dispose();
    _xboxController.dispose();
    _nintendoController.dispose();
    _hoursControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: _backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: _primaryColor),
              const SizedBox(height: 16),
              Text(
                'Carregando perfil...',
                style: TextStyle(color: _textSecondary, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Text(
          'Meu Perfil',
          style: TextStyle(color: _textPrimary, fontWeight: FontWeight.w600),
        ),
        actions: [
          // Botão para ver jogos removidos
          if (_removedGames.isNotEmpty)
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color(0xFFF59E0B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Badge(
                  smallSize: 8,
                  backgroundColor: Color(0xFFF59E0B),
                  child: Icon(
                    Icons.restore,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                ),
              ),
              onPressed: _showRemovedGamesDialog,
              tooltip: 'Jogos Removidos',
            ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.share, color: _primaryColor, size: 20),
            ),
            onPressed: _showShareMenu,
            tooltip: 'Compartilhar Perfil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStatistics(),
            const SizedBox(height: 24),
            _buildPlatformIds(),
            const SizedBox(height: 24),
            _buildCompletedGames(),
            const SizedBox(height: 24),
            _buildAddGamesButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _borderColor, width: 3),
                  image: DecorationImage(
                    image: NetworkImage(_userProfile.avatarUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: GestureDetector(
                  onTap: _showStatusSelector,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _selectedStatus.color,
                      shape: BoxShape.circle,
                      border: Border.all(color: _surfaceColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      _selectedStatus.icon,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userProfile.username,
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userProfile.email,
                  style: TextStyle(color: _textSecondary, fontSize: 14),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _showStatusSelector,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedStatus.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _selectedStatus.color,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _selectedStatus.icon,
                          size: 12,
                          color: _selectedStatus.color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _selectedStatus.name,
                          style: TextStyle(
                            color: _selectedStatus.color,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 12,
                          color: _textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    final completedGames = _visibleCompletedGames.length;
    final totalHours = _userProfile.totalPlaytime;
    final averageHours = completedGames > 0
        ? (totalHours / completedGames).toStringAsFixed(1)
        : '0.0';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estatísticas',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Jogos Completados',
                completedGames.toString(),
                Icons.videogame_asset_outlined,
                _primaryColor,
              ),
              _buildStatItem(
                'Horas Totais',
                '${totalHours}h',
                Icons.timer_outlined,
                _secondaryColor,
              ),
              _buildStatItem(
                'Média por Jogo',
                '${averageHours}h',
                Icons.assessment_outlined,
                Color(0xFF8B5CF6),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: _textSecondary, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPlatformIds() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IDs das Plataformas',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Adicione seus IDs para conectar com outros jogadores',
            style: TextStyle(color: _textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 16),
          _buildPlatformField(
            'Steam ID',
            _steamController,
            _platformLogos['steam']!,
          ),
          const SizedBox(height: 12),
          _buildPlatformField('PSN ID', _psnController, _platformLogos['psn']!),
          const SizedBox(height: 12),
          _buildPlatformField(
            'Xbox Live',
            _xboxController,
            _platformLogos['xbox']!,
          ),
          const SizedBox(height: 12),
          _buildPlatformField(
            'Nintendo',
            _nintendoController,
            _platformLogos['nintendo']!,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: const Text(
                'Salvar IDs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformField(
    String label,
    TextEditingController controller,
    String logoUrl,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: _textSecondary),
          prefixIcon: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            child: Image.network(logoUrl, fit: BoxFit.contain),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _primaryColor, width: 2),
          ),
          filled: true,
          fillColor: _backgroundColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        style: TextStyle(color: _textPrimary),
      ),
    );
  }

  Widget _buildCompletedGames() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Jogos Completados',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _visibleCompletedGames.length.toString(),
                      style: TextStyle(
                        color: _primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (_removedGames.isNotEmpty)
                TextButton(
                  onPressed: _showRemovedGamesDialog,
                  child: Text(
                    'Ver removidos',
                    style: TextStyle(color: _textSecondary, fontSize: 12),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_visibleCompletedGames.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _borderColor, width: 1),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.videogame_asset_outlined,
                    size: 60,
                    color: _textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum jogo completado ainda',
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Complete seus primeiros jogos para vê-los aqui!',
                    style: TextStyle(
                      color: _textSecondary.withOpacity(0.7),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            Column(
              children: _visibleCompletedGames.map((game) {
                return _buildCompletedGameItem(game);
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildCompletedGameItem(Game game) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showGameOptionsDialog(game),
          borderRadius: BorderRadius.circular(12),
          hoverColor: _primaryColor.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // CAPA DO JOGO
                Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(game.coverUrl),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                        style: TextStyle(
                          color: _textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // LINHA DE HORAS EDITÁVEL
                      GestureDetector(
                        onTap: () => _showEditHoursDialog(game),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _surfaceColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _borderColor, width: 1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 14,
                                color: _secondaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${game.playtime}',
                                style: TextStyle(
                                  color: _textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                'h jogadas',
                                style: TextStyle(
                                  color: _textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.edit_outlined,
                                size: 12,
                                color: _textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // PLATAFORMA E DATA
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              game.platform,
                              style: TextStyle(
                                color: _primaryColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (game.completionDate != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 11,
                                  color: _secondaryColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${game.completionDate!.day}/${game.completionDate!.month}/${game.completionDate!.year}',
                                  style: TextStyle(
                                    color: _textSecondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ÍCONE DE CONFIRMAÇÃO
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: _secondaryColor, width: 1),
                  ),
                  child: Icon(Icons.check, color: _secondaryColor, size: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddGamesButton() {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () => _showAddGamesDialog(),
        style: OutlinedButton.styleFrom(
          foregroundColor: _primaryColor,
          side: BorderSide(color: _primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        icon: Icon(Icons.add, size: 18),
        label: Text(
          'Adicionar Jogos Completados',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showAddGamesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _borderColor, width: 1),
        ),
        title: Text(
          'Adicionar Jogos',
          style: TextStyle(color: _textPrimary, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Para adicionar jogos completados, você pode:',
              style: TextStyle(color: _textSecondary),
            ),
            const SizedBox(height: 12),
            _buildAddOption(
              Icons.library_books,
              'Ir para Biblioteca',
              'Navegue pela sua biblioteca e marque jogos como completados',
              () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) => LibraryScreen()));
              },
            ),
            const SizedBox(height: 12),
            _buildAddOption(
              Icons.search,
              'Buscar no Catálogo',
              'Encontre jogos no catálogo e adicione aos completados',
              () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) => CatalogScreen()));
              },
            ),
            const SizedBox(height: 12),
            _buildAddOption(
              Icons.star,
              'Jogos Recomendados',
              'Veja recomendações baseadas no seu perfil',
              () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) => RecommendationsScreen()));
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: _textSecondary)),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOption(
    IconData icon,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderColor, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: _primaryColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(color: _textSecondary, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
