// game_details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_model.dart';
import 'game_provider.dart';

class GameDetailsScreen extends StatefulWidget {
  final Game game;

  const GameDetailsScreen({super.key, required this.game});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
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
}
