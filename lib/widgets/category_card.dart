import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/colors.dart';
import '../utils/theme.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            // Category Icon Container
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: _getCategoryGradient(category.id),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _getCategoryGradient(category.id)
                        .colors
                        .first
                        .withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  category.icon,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Category Name
            Text(
              category.name,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkGrey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  
  LinearGradient _getCategoryGradient(String categoryId) {
    switch (categoryId) {
      case 'handloom':
        return AppColors.saffronGradient;
      case 'pottery':
        return AppColors.maroonGradient;
      case 'jewelry':
        return AppColors.greenGradient;
      case 'paintings':
        return const LinearGradient(
          colors: [AppColors.terracotta, Color(0xFFD2691E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'woodwork':
        return const LinearGradient(
          colors: [Color(0xFF8B4513), Color(0xFFA0522D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'bamboo':
        return const LinearGradient(
          colors: [Color(0xFF228B22), Color(0xFF32CD32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return AppColors.saffronGradient;
    }
  }
}