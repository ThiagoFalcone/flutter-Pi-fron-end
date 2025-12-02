import 'package:flutter/material.dart';

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
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
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
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Colors.grey),
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
                    backgroundColor: Colors.blue,
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
            Icon(icon, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                onSelected(option);
              },
              backgroundColor: Colors.grey[50],
              selectedColor: Colors.blue,
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
