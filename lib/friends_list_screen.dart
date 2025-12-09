// friends_list_screen.dart
import 'package:flutter/material.dart';
import 'custom_change_notifier.dart';
import 'game_model.dart';
import 'game_provider.dart';
import 'public_profile_screen.dart';

class FriendsListScreen extends StatefulWidget {
  final String userId;
  final String title;
  final List<User> friends;

  const FriendsListScreen({
    super.key,
    required this.userId,
    required this.title,
    required this.friends,
  });

  @override
  State<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  void _navigateToProfile(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PublicProfileScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if (widget.friends.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.title.contains('Seguidores')
                        ? 'Nenhum seguidor ainda'
                        : 'Você ainda não está seguindo ninguém',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.friends.length,
            itemBuilder: (context, index) {
              final user = widget.friends[index];
              return _buildFriendCard(user, gameProvider);
            },
          );
        },
      ),
    );
  }

  Widget _buildFriendCard(User user, GameProvider gameProvider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF1A1A2E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToProfile(user),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // AVATAR
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF667EEA),
                backgroundImage:
                    user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
                child: user.avatarUrl == null
                    ? Text(
                        user.username[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),

              // INFORMAÇÕES
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user.bio != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        user.bio!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildStatChip(
                          Icons.videogame_asset,
                          '${user.totalGames} jogos',
                        ),
                        const SizedBox(width: 8),
                        _buildStatChip(
                          Icons.timer,
                          '${user.totalPlaytime}h',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // BOTÃO SEGUIR (se não for o próprio usuário)
              if (user.id != widget.userId)
                IconButton(
                  icon: Icon(
                    user.isFollowing
                        ? Icons.person_remove
                        : Icons.person_add,
                    color: user.isFollowing
                        ? Colors.red
                        : const Color(0xFF667EEA),
                  ),
                  onPressed: () {
                    gameProvider.toggleFollow(user.id);
                    setState(() {});
                  },
                  tooltip: user.isFollowing ? 'Deixar de seguir' : 'Seguir',
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
