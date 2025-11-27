// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'game_model.dart';

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
    UserStatus('Online', Icons.circle, Colors.green),
    UserStatus('Ocupado', Icons.remove_circle, Colors.orange),
    UserStatus('Ausente', Icons.timer, Colors.yellow),
    UserStatus('Offline', Icons.circle_outlined, Colors.grey),
    UserStatus('Jogando', Icons.videogame_asset, Colors.purple),
    UserStatus('Não perturbe', Icons.do_not_disturb, Colors.red),
  ];

  // Opções de compartilhamento
  final List<ShareOption> _shareOptions = [
    ShareOption(
      'WhatsApp',
      Icons.chat,
      Colors.green,
      'https://web.whatsapp.com/',
    ),
    ShareOption(
      'Facebook',
      Icons.facebook,
      Colors.blue,
      'https://facebook.com/',
    ),
    ShareOption(
      'Instagram',
      Icons.camera_alt,
      Colors.pink,
      'https://instagram.com/',
    ),
    ShareOption(
      'Discord',
      Icons.chat_bubble,
      Colors.purple,
      'https://discord.com/',
    ),
    ShareOption(
      'Twitter',
      Icons.trending_up,
      Colors.blue,
      'https://twitter.com/',
    ),
    ShareOption('Copiar Link', Icons.link, Colors.grey, null),
  ];

  UserStatus _selectedStatus = UserStatus('Online', Icons.circle, Colors.green);

  // Controladores para edição de horas
  final Map<String, TextEditingController> _hoursControllers = {};

  // Lista de jogos removidos temporariamente
  final List<String> _removedGames = [];

  @override
  void initState() {
    super.initState();
    _initializeUserProfile();
  }

  void _initializeUserProfile() {
    _userProfile = UserProfile(
      id: '1',
      username: 'GameMaster',
      email: 'gamer@example.com',
      steamId: 'STEAM_0:1:12345678',
      psnId: 'PSN_GameMaster',
      xboxId: 'XboxGameMaster#1234',
      nintendoId: 'SW-1234-5678-9012',
      completedGames: [
        Game(
          id: '1',
          title: 'The Witcher 3: Wild Hunt',
          developer: 'CD Projekt Red',
          publisher: 'CD Projekt',
          price: 79.90,
          rating: 4.9,
          coverUrl:
              'https://images.igdb.com/igdb/image/upload/t_cover_big/co2rry.jpg',
          description:
              'RPG de mundo aberto em um universo de fantasia sombria.',
          category: 'RPG',
          platforms: ['PC', 'PlayStation', 'Xbox', 'Switch'],
          releaseYear: 2015,
          isCompleted: true,
          completionDate: DateTime(2023, 10, 15),
          playtime: 120,
          platform: 'PC',
          isInLibrary: true,
        ),
        Game(
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
      ],
      totalPlaytime: 450,
      avatarUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
    );

    // Inicializar controladores para cada jogo
    for (var game in _userProfile.completedGames) {
      _hoursControllers[game.id] = TextEditingController(
        text: game.playtime.toString(),
      );
    }

    _steamController.text = _userProfile.steamId ?? '';
    _psnController.text = _userProfile.psnId ?? '';
    _xboxController.text = _userProfile.xboxId ?? '';
    _nintendoController.text = _userProfile.nintendoId ?? '';
  }

  void _saveProfile() {
    setState(() {
      // Atualizar IDs das plataformas
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
    _showSnackBar('Perfil atualizado com sucesso!');
  }

  void _updateGameHours(String gameId, String hoursText) {
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
  }

  void _removeGame(String gameId) {
    setState(() {
      // Adicionar à lista de jogos removidos
      _removedGames.add(gameId);

      // Remover das horas controllers
      _hoursControllers.remove(gameId);

      // Mostrar mensagem de confirmação
      _showSnackBar('Jogo removido da lista de completados');
    });
  }

  void _restoreGame(Game game) {
    setState(() {
      // Remover da lista de removidos
      _removedGames.remove(game.id);

      // Adicionar de volta ao controlador de horas
      _hoursControllers[game.id] = TextEditingController(
        text: game.playtime.toString(),
      );

      _showSnackBar('Jogo restaurado com sucesso');
    });
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
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                      color: const Color(0xFF667EEA).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.timer,
                      color: Color(0xFF667EEA),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Editar Horas',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          game.title,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
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
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF667EEA),
                        width: 2,
                      ),
                    ),
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        suffixText: 'horas',
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Digite o número total de horas jogadas',
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.7),
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
                        foregroundColor: Colors.grey,
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
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
                        backgroundColor: const Color(0xFF667EEA),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 2,
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
      backgroundColor: const Color(0xFF1A1A2E),
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
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Opções do Jogo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Opção de editar horas
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF667EEA).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.timer, color: Color(0xFF667EEA)),
                ),
                title: Text(
                  'Editar Horas Jogadas',
                  style: TextStyle(color: Colors.white),
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
                    color: Colors.red.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
                title: Text(
                  'Remover da Lista',
                  style: TextStyle(color: Colors.white),
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
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Remover Jogo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Tem certeza que deseja remover "${game.title}" da sua lista de jogos completados?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: Colors.grey)),
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
      backgroundColor: const Color(0xFF1A1A2E),
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
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Jogos Removidos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      removedGames.length.toString(),
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
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
          style: TextStyle(color: Colors.white, fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${game.playtime}h jogadas • ${game.platform}',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        trailing: IconButton(
          icon: Icon(Icons.restore, color: Colors.green),
          onPressed: () => _restoreGame(game),
        ),
      ),
    );
  }

  void _showShareMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
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
              const Text(
                'Compartilhar Perfil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Compartilhe seu perfil de jogador nas redes sociais',
                style: TextStyle(color: Colors.grey, fontSize: 14),
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
          color: const Color(0xFF2A2A3E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: option.color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(option.icon, color: option.color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              option.name,
              style: const TextStyle(
                color: Colors.white,
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
      backgroundColor: const Color(0xFF1A1A2E),
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
              const Text(
                'Selecionar Status',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
          color: status.color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(status.icon, color: status.color),
      ),
      title: Text(status.name, style: const TextStyle(color: Colors.white)),
      trailing: _selectedStatus.name == status.name
          ? const Icon(Icons.check, color: Color(0xFF667EEA))
          : null,
      onTap: () {
        setState(() {
          _selectedStatus = status;
        });
        Navigator.pop(context);
        _showSnackBar('Status alterado para: ${status.name}');
      },
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF667EEA),
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
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text(
          'Meu Perfil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Botão para ver jogos removidos
          if (_removedGames.isNotEmpty)
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Badge(
                  smallSize: 8,
                  backgroundColor: Colors.orange,
                  child: const Icon(
                    Icons.restore,
                    color: Colors.orange,
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
                color: const Color(0xFF2A2A3E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.share, color: Colors.white, size: 20),
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
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
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
                  border: Border.all(color: const Color(0xFF667EEA), width: 3),
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
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _selectedStatus.color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1A1A2E),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _selectedStatus.icon,
                      size: 10,
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userProfile.email,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                      color: _selectedStatus.color.withOpacity(0.2),
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 12,
                          color: Colors.grey,
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estatísticas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Jogos Completados',
                _visibleCompletedGames.length.toString(),
                Icons.videogame_asset,
              ),
              _buildStatItem(
                'Horas Jogadas',
                '${_userProfile.totalPlaytime}h',
                Icons.timer,
              ),
              _buildStatItem('Plataformas', '4', Icons.computer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A3E),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF667EEA), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPlatformIds() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'IDs das Plataformas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
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
                backgroundColor: const Color(0xFF667EEA),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 2,
              ),
              child: const Text(
                'Salvar IDs',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3A3A4E), width: 1),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
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
            borderSide: const BorderSide(color: Color(0xFF667EEA), width: 2),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCompletedGames() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Jogos Completados',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF667EEA).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _visibleCompletedGames.length.toString(),
                  style: const TextStyle(
                    color: Color(0xFF667EEA),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_visibleCompletedGames.isEmpty)
            const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.videogame_asset_outlined,
                    size: 60,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Nenhum jogo completado ainda',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
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
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showGameOptionsDialog(game),
          borderRadius: BorderRadius.circular(12),
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
                        color: Colors.black.withOpacity(0.5),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // LINHA DE HORAS EDITÁVEL
                      GestureDetector(
                        onTap: () => _showEditHoursDialog(game),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A2E),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFF667EEA).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                size: 14,
                                color: Color(0xFF667EEA),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${game.playtime}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                'h jogadas',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.edit_outlined,
                                size: 12,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // PLATAFORMA E DATA
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF667EEA),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              game.platform,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (game.completionDate != null)
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 10,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${game.completionDate!.day}/${game.completionDate!.month}/${game.completionDate!.year}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 10,
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

                // ÍCONE DE CONFIRMAÇÃO E MENU
                Column(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Completo',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Classe para representar o status do usuário
class UserStatus {
  final String name;
  final IconData icon;
  final Color color;

  UserStatus(this.name, this.icon, this.color);
}

// Classe para representar as opções de compartilhamento
class ShareOption {
  final String name;
  final IconData icon;
  final Color color;
  final String? url;

  ShareOption(this.name, this.icon, this.color, this.url);
}
