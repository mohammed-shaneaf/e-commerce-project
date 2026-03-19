import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class CategoriesFilter extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoriesFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const _categoryIcons = <String, IconData>{
    'All': Icons.grid_view_rounded,
    'electronics': Icons.devices_rounded,
    'jewelery': Icons.diamond_rounded,
    "men's clothing": Icons.male_rounded,
    "women's clothing": Icons.female_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          final icon = _categoryIcons[category] ?? Icons.category_rounded;

          return Padding(
            padding: EdgeInsets.only(
              right: index < categories.length - 1 ? 10 : 0,
            ),
            child: GestureDetector(
              onTap: () => onCategorySelected(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [AppTheme.primaryAccent, Color(0xFF8B83FF)],
                        )
                      : null,
                  color: isSelected
                      ? null
                      : (isDark ? AppTheme.darkCard : AppTheme.surfaceMedium),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryAccent.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 17,
                      color: isSelected
                          ? Colors.white
                          : (isDark
                                ? AppTheme.darkTextSecondary
                                : AppTheme.textSecondary),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _capitalize(category),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                  ? AppTheme.darkTextSecondary
                                  : AppTheme.textSecondary),
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
