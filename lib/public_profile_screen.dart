// public_profile_screen.dart
import 'package:flutter/material.dart';
import 'custom_change_notifier.dart';
import 'game_model.dart';
import 'game_provider.dart';
import 'friends_list_screen.dart';

class PublicProfileScreen extends StatefulWidget {
  final User user;

  const PublicProfileScreen({super.key, required this.user});

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        // Atualizar o usuário para ter o estado atual de seguir
        final user = gameProvider.getUserById(widget.user.id) ?? widget.user;

        return Scaffold(
          backgroundColor: const Color(0xFF0F0F1E),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1A1A2E),
            title: Text(
              user.username,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  user.isFollowing ? Icons.person_remove : Icons.person_add,
                  color: user.isFollowing ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  gameProvider.toggleFollow(user.id);
                  setState(() {});
                },
                tooltip: user.isFollowing ? 'Deixar de seguir' : 'Seguir',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // CABEÇALHO DO PERFIL
                _buildProfileHeader(user),
                const SizedBox(height: 24),

                // ESTATÍSTICAS
                _buildStatistics(user),
                const SizedBox(height: 24),

                // BIO
                if (user.bio != null) ...[
                  _buildBio(user.bio!),
                  const SizedBox(height: 24),
                ],

                // JOGOS DO USUÁRIO
                _buildUserGames(user, gameProvider),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(User user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // AVATAR
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color(0xFF667EEA),
            backgroundImage:
                user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
            child: user.avatarUrl == null
                ? Text(
                    user.username[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            user.username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (user.joinDate != null) ...[
            const SizedBox(height: 4),
            Text(
              'Membro desde ${_formatDate(user.joinDate!)}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatistics(User user) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        // Obter lista de seguidores deste usuário
        final userFollowers = gameProvider.getFollowersForUser(user.id);
        
        // Obter lista de quem este usuário está seguindo
        final userFollowing = gameProvider.getFollowingForUser(user.id);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Jogos',
                user.totalGames.toString(),
                Icons.videogame_asset,
              ),
              _buildStatItem(
                'Horas',
                '${user.totalPlaytime}h',
                Icons.timer,
              ),
              _buildStatItemWithTap(
                'Seguidores',
                user.followersCount.toString(),
                Icons.people,
                () => _showFriendsList(context, gameProvider, userFollowers, 'Seguidores de ${user.username}'),
              ),
              _buildStatItemWithTap(
                'Seguindo',
                user.followingCount.toString(),
                Icons.person_add,
                () => _showFriendsList(context, gameProvider, userFollowing, '${user.username} está seguindo'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFriendsList(BuildContext context, GameProvider gameProvider, List<User> friends, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FriendsListScreen(
          userId: widget.user.id,
          title: title,
          friends: friends,
        ),
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
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItemWithTap(String label, String value, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios,
                size: 10,
                color: Color(0xFF667EEA),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBio(String bio) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sobre',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              bio,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserGames(User user, GameProvider gameProvider) {
    // Obter jogos que o usuário avaliou/comentou
    final userReviews = gameProvider.gameReviews
        .where((review) => review.userId == user.id)
        .toList();

    if (userReviews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.videogame_asset_outlined,
                size: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'Nenhum jogo avaliado ainda',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Obter jogos únicos
    final gameIds = userReviews.map((r) => r.gameId).toSet();
    final games = gameIds
        .map((id) => gameProvider.getGameById(id))
        .where((game) => game != null)
        .cast<Game>()
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jogos Avaliados',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...games.map((game) {
            final review = userReviews.firstWhere((r) => r.gameId == game.id);
            return _buildGameReviewCard(game, review);
          }),
        ],
      ),
    );
  }

  Widget _buildGameReviewCard(Game game, GameReview review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // CAPA DO JOGO
          Container(
            width: 60,
            height: 80,
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
                  return const Icon(
                    Icons.gamepad,
                    color: Colors.grey,
                    size: 30,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // INFORMAÇÕES
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating
                          ? Icons.star
                          : Icons.star_border,
                      color: index < review.rating ? Colors.amber : Colors.grey,
                      size: 14,
                    );
                  }),
                ),
                if (review.comment.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    review.comment,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

