// screens/opinion_editor_screen.dart
// ignore_for_file: unused_import, unused_field, deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_teste/models/profile_constant.dart'
    show ProfileConstants;
import '../models/game_model.dart';
import '../models/opinion.dart';

class OpinionEditorScreen extends StatefulWidget {
  final Opinion? opinion;
  final String? gameId;
  final String? gameTitle;

  const OpinionEditorScreen({
    super.key,
    this.opinion,
    this.gameId,
    this.gameTitle,
  });

  @override
  State<OpinionEditorScreen> createState() => _OpinionEditorScreenState();
}

class _OpinionEditorScreenState extends State<OpinionEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _reviewController;
  late TextEditingController _playtimeController;
  late List<String> _selectedTags;
  double _rating = 3.0;
  bool _recommended = true;
  String? _selectedGameId;
  String? _selectedGameTitle;
  final List<Game> _availableGames = [];
  final List<String> _availableTags = [
    'RPG',
    'Ação',
    'Aventura',
    'Estratégia',
    'Esportes',
    'Corrida',
    'Tiro',
    'Mundo Aberto',
    'Multijogador',
    'História Profunda',
    'Gráficos Lindos',
    'Jogabilidade',
    'Som Incrível',
    'Desafio',
    'Casual',
    'Competitivo',
    'Cooperativo',
    'Indie',
    'AAA',
    'Clássico',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.opinion?.title ?? '');
    _reviewController = TextEditingController(
      text: widget.opinion?.review ?? '',
    );
    _playtimeController = TextEditingController(
      text: widget.opinion?.playtime.toString() ?? '0',
    );
    _selectedTags = List.from(widget.opinion?.tags ?? []);
    _rating = widget.opinion?.rating ?? 3.0;
    _recommended = widget.opinion?.recommended ?? true;
    _selectedGameId = widget.opinion?.gameId ?? widget.gameId;
    _selectedGameTitle = widget.gameTitle;

    _loadGames();
  }

  Future<void> _loadGames() async {
    // Se já temos um gameId específico passado como parâmetro
    if (_selectedGameId != null && widget.gameTitle != null) {
      _availableGames.add(
        Game(
          id: _selectedGameId!,
          title: widget.gameTitle!,
          developer: 'Carregando...',
          publisher: '',
          price: 0,
          rating: 0,
          coverUrl: '',
          description: '',
          category: '',
          platforms: [],
          releaseYear: 0,
          isCompleted: false,
          completionDate: null,
          playtime: 0,
          platform: '',
          isInLibrary: false,
        ),
      );
    } else {
      // Carregar todos os jogos do catálogo
      _availableGames.addAll([
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
          id: '2',
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
          isCompleted: false,
          completionDate: null,
          playtime: 0,
          platform: 'PC',
          isInLibrary: true,
        ),
        Game(
          id: '3',
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
          isCompleted: false,
          completionDate: null,
          playtime: 0,
          platform: 'PC',
          isInLibrary: true,
        ),
      ]);
    }

    setState(() {});
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  void _submitOpinion() {
    if (_formKey.currentState!.validate() && _selectedGameId != null) {
      final opinion = Opinion(
        id: widget.opinion?.id ?? Random().nextInt(999999).toString(),
        gameId: _selectedGameId!,
        userId: '1',
        rating: _rating,
        title: _titleController.text,
        review: _reviewController.text,
        tags: _selectedTags,
        createdAt: widget.opinion?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        playtime: int.tryParse(_playtimeController.text) ?? 0,
        recommended: _recommended,
        likes: widget.opinion?.likes ?? 0,
        dislikes: widget.opinion?.dislikes ?? 0,
        likedBy: widget.opinion?.likedBy ?? [],
        dislikedBy: widget.opinion?.dislikedBy ?? [],
      );

      Navigator.pop(context, opinion);
    } else if (_selectedGameId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione um jogo'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ProfileConstants.surfaceColor,
        elevation: 0,
        title: Text(
          widget.opinion == null ? 'Nova Opinião' : 'Editar Opinião',
          style: TextStyle(
            color: ProfileConstants.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _submitOpinion,
            tooltip: 'Salvar',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seleção de Jogo
              Card(
                elevation: 0,
                color: ProfileConstants.surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: ProfileConstants.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sobre qual jogo?',
                        style: TextStyle(
                          color: ProfileConstants.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (widget.gameId != null && widget.gameTitle != null)
                        // Mostrar jogo pré-selecionado
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: ProfileConstants.primaryColor.withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ProfileConstants.primaryColor.withOpacity(
                                0.3,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.gameTitle!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Jogo pré-selecionado',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ProfileConstants.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        DropdownButtonFormField<String>(
                          value: _selectedGameId,
                          decoration: InputDecoration(
                            hintText: 'Selecione um jogo',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: ProfileConstants.borderColor,
                              ),
                            ),
                          ),
                          items: _availableGames
                              .map(
                                (game) => DropdownMenuItem(
                                  value: game.id,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(game.coverUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              game.title,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              game.category,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: ProfileConstants
                                                    .textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGameId = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Selecione um jogo';
                            }
                            return null;
                          },
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Avaliação
              Card(
                elevation: 0,
                color: ProfileConstants.surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: ProfileConstants.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sua Avaliação',
                        style: TextStyle(
                          color: ProfileConstants.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              _rating.toStringAsFixed(1),
                              style: TextStyle(
                                color: ProfileConstants.primaryColor,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return IconButton(
                                  icon: Icon(
                                    index < _rating.floor()
                                        ? Icons.star
                                        : index < _rating
                                        ? Icons.star_half
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _rating = index + 1.0;
                                    });
                                  },
                                );
                              }),
                            ),
                            Slider(
                              value: _rating,
                              min: 0.0,
                              max: 5.0,
                              divisions: 10,
                              label: _rating.toStringAsFixed(1),
                              onChanged: (value) {
                                setState(() {
                                  _rating = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ChoiceChip(
                            label: const Text('Recomendo'),
                            selected: _recommended,
                            selectedColor: Colors.green,
                            onSelected: (selected) {
                              setState(() {
                                _recommended = selected;
                              });
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Não Recomendo'),
                            selected: !_recommended,
                            selectedColor: Colors.red,
                            onSelected: (selected) {
                              setState(() {
                                _recommended = !selected;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Horas Jogadas
              Card(
                elevation: 0,
                color: ProfileConstants.surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: ProfileConstants.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Horas Jogadas',
                        style: TextStyle(
                          color: ProfileConstants.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _playtimeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Quantas horas você jogou?',
                          prefixIcon: const Icon(Icons.timer),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe as horas jogadas';
                          }
                          final hours = int.tryParse(value);
                          if (hours == null || hours < 0) {
                            return 'Horas inválidas';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Título da Opinião
              Card(
                elevation: 0,
                color: ProfileConstants.surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: ProfileConstants.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Título da Opinião',
                        style: TextStyle(
                          color: ProfileConstants.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Dê um título para sua opinião',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        maxLength: 100,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite um título';
                          }
                          if (value.length < 5) {
                            return 'Título muito curto';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Texto da Opinião
              Card(
                elevation: 0,
                color: ProfileConstants.surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: ProfileConstants.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sua Opinião',
                        style: TextStyle(
                          color: ProfileConstants.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _reviewController,
                        decoration: InputDecoration(
                          hintText: 'Compartilhe sua experiência com o jogo...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 8,
                        maxLength: 2000,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite sua opinião';
                          }
                          if (value.length < 50) {
                            return 'A opinião deve ter pelo menos 50 caracteres';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Tags
              Card(
                elevation: 0,
                color: ProfileConstants.surfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: ProfileConstants.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tags',
                        style: TextStyle(
                          color: ProfileConstants.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Selecione tags que descrevam sua experiência',
                        style: TextStyle(
                          color: ProfileConstants.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _availableTags
                            .map(
                              (tag) => FilterChip(
                                label: Text(tag),
                                selected: _selectedTags.contains(tag),
                                onSelected: (selected) => _toggleTag(tag),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Botão de Salvar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitOpinion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProfileConstants.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    widget.opinion == null
                        ? 'Publicar Opinião'
                        : 'Atualizar Opinião',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _reviewController.dispose();
    _playtimeController.dispose();
    super.dispose();
  }
}
