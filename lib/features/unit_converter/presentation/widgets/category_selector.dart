import 'package:flutter/material.dart';

/// Selector chips for conversion categories.
class CategorySelector extends StatelessWidget {
  /// Creates [CategorySelector].
  const CategorySelector({required this.categories, required this.selected, required this.onSelected, super.key});

  /// Available categories.
  final List<String> categories;

  /// Selected category.
  final String selected;

  /// Selection callback.
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) {
          final String value = categories[index];
          return ChoiceChip(
            label: Text(value),
            selected: selected == value,
            onSelected: (_) => onSelected(value),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}
