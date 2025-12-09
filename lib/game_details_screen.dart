// game_details_screen.dart
import 'package:flutter/material.dart';
import 'custom_change_notifier.dart';
import 'game_model.dart';
import 'game_provider.dart';
import 'public_profile_screen.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;

  const GameDetailsScreen({super.key, required this.game});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    // Carregar reviews de exemplo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameProvider = ChangeNotifierProvider.of<GameProvider>(context);
      gameProvider.loadReviewsFromLocal();
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final isInLibrary = gameProvider.isGameInLibrary(widget.game.id);

        return Scaffold(
          backgroundColor: const Color(0xFF0F0F1E),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: const Color(0xFF1A1A2E),
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // CAPA DO JOGO
                      Image.network(
                        widget.game.coverUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade800,
                            child: const Icon(
                              Icons.gamepad,
                              size: 100,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                      // GRADIENTE
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              const Color(0xFF0F0F1E).withOpacity(0.8),
                              const Color(0xFF0F0F1E),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TÍTULO E BOTÃO
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.game.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isInLibrary
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline,
                              color: isInLibrary
                                  ? Colors.green
                                  : const Color(0xFF667EEA),
                              size: 32,
                            ),
                            onPressed: () =>
                                _toggleLibrary(context, gameProvider),
                            tooltip: isInLibrary
                                ? 'Remover da biblioteca'
                                : 'Adicionar à biblioteca',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // DESENVOLVEDOR
                      Text(
                        widget.game.developer,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // INFORMAÇÕES
                      Row(
                        children: [
                          _buildDetailInfo('Categoria', widget.game.category),
                          _buildDetailInfo(
                            'Lançamento',
                            widget.game.releaseYear.toString(),
                          ),
                          _buildDetailInfo(
                            'Avaliação',
                            widget.game.rating.toString(),
                          ),
                          _buildDetailInfo(
                            'Preço',
                            'R\$${widget.game.price.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // PLATAFORMAS
                      Row(
                        children: [
                          _buildDetailInfo(
                            'Plataformas',
                            _formatPlatforms(widget.game.platforms),
                          ),
                          _buildDetailInfo(
                            'Plataforma Principal',
                            widget.game.platform,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // DESCRIÇÃO
                      const Text(
                        'Descrição',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.game.description,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // SEÇÃO DE AVALIAÇÕES E COMENTÁRIOS
                      _buildReviewsSection(context, gameProvider),

                      const SizedBox(height: 24),

                      // BOTÃO COMPRAR
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _showSnackBar(
                              context,
                              'Redirecionando para compra...',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF667EEA),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Comprar Agora',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleLibrary(BuildContext context, GameProvider gameProvider) {
    final isInLibrary = gameProvider.isGameInLibrary(widget.game.id);

    if (isInLibrary) {
      gameProvider.removeFromLibrary(widget.game.id);
      _showSnackBar(context, '${widget.game.title} removido da biblioteca!');
    } else {
      gameProvider.addGame(widget.game);
      _showSnackBar(context, '${widget.game.title} adicionado à biblioteca!');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF667EEA),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Método para formatar a lista de plataformas como string
  String _formatPlatforms(List<String> platforms) {
    if (platforms.isEmpty) return 'N/A';
    if (platforms.length == 1) return platforms.first;
    if (platforms.length == 2) return platforms.join(', ');
    return '${platforms.take(2).join(', ')}+${platforms.length - 2}';
  }

  Widget _buildDetailInfo(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context, GameProvider gameProvider) {
    final reviews = gameProvider.getReviewsForGame(widget.game.id);
    final userReview = gameProvider.getUserReviewForGame(widget.game.id);
    final averageRating = gameProvider.getAverageRatingForGame(widget.game.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TÍTULO E MÉDIA DE AVALIAÇÕES
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Avaliações e Comentários',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (averageRating > 0)
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${reviews.length})',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 16),

        // FORMULÁRIO DE AVALIAÇÃO DO USUÁRIO
        if (userReview == null)
          _buildReviewForm(context, gameProvider)
        else
          _buildUserReviewCard(context, gameProvider, userReview),

        const SizedBox(height: 24),

        // LISTA DE COMENTÁRIOS
        if (reviews.isNotEmpty) ...[
          Text(
            'Comentários da Comunidade (${reviews.length})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...reviews.map((review) => _buildReviewCard(context, gameProvider, review)),
        ] else
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Nenhum comentário ainda.\nSeja o primeiro a avaliar!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildReviewForm(BuildContext context, GameProvider gameProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF667EEA).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sua Avaliação',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Seletor de Estrelas
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedRating = index + 1;
                  });
                },
                child: Icon(
                  index < _selectedRating ? Icons.star : Icons.star_border,
                  color: index < _selectedRating
                      ? Colors.amber
                      : Colors.grey,
                  size: 32,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Campo de Comentário
          TextField(
            controller: _commentController,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Escreva seu comentário...',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF2A2A3E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),

          // Botão Enviar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedRating > 0
                  ? () {
                      if (_commentController.text.trim().isNotEmpty) {
                        gameProvider.addReview(
                          widget.game.id,
                          _selectedRating,
                          _commentController.text.trim(),
                        );
                        setState(() {
                          _selectedRating = 0;
                          _commentController.clear();
                        });
                        _showSnackBar(context, 'Avaliação enviada com sucesso!');
                      } else {
                        _showSnackBar(context, 'Por favor, escreva um comentário');
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667EEA),
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Enviar Avaliação',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserReviewCard(
    BuildContext context,
    GameProvider gameProvider,
    GameReview review,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF667EEA),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFF667EEA),
                    child: Text(
                      review.username[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    review.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < review.rating ? Icons.star : Icons.star_border,
                      color: index < review.rating ? Colors.amber : Colors.grey,
                      size: 16,
                    );
                  }),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(review.reviewDate),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  gameProvider.deleteReview(review.id);
                  _showSnackBar(context, 'Avaliação removida');
                },
                icon: const Icon(Icons.delete_outline, size: 16, color: Colors.red),
                label: const Text(
                  'Remover',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    BuildContext context,
    GameProvider gameProvider,
    GameReview review,
  ) {
    final currentUserId = 'user_1'; // Em produção, viria de autenticação
    final isLiked = review.likedBy.contains(currentUserId);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => _navigateToUserProfile(context, gameProvider, review.userId),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF667EEA),
                  child: Text(
                    review.username[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _navigateToUserProfile(context, gameProvider, review.userId),
                      child: Text(
                        review.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: index < review.rating
                                ? Colors.amber
                                : Colors.grey,
                            size: 14,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          _formatDate(review.reviewDate),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: isLiked ? const Color(0xFF667EEA) : Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  gameProvider.toggleLikeReview(review.id, currentUserId);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 4),
              Text(
                '${review.likes}',
                style: TextStyle(
                  color: isLiked ? const Color(0xFF667EEA) : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return 'Há ${difference.inMinutes} minutos';
      }
      return 'Há ${difference.inHours} horas';
    } else if (difference.inDays < 7) {
      return 'Há ${difference.inDays} dias';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _navigateToUserProfile(BuildContext context, GameProvider gameProvider, String userId) {
    final user = gameProvider.getUserById(userId);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublicProfileScreen(user: user),
        ),
      );
    } else {
      _showSnackBar(context, 'Perfil do usuário não encontrado');
    }
  }
}
