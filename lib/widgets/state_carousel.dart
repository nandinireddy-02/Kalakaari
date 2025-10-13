import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/theme.dart';

class StateCarousel extends StatelessWidget {
  final List<StateTheme> stateThemes;
  final Function(StateTheme) onStateTap;

  const StateCarousel({
    super.key,
    required this.stateThemes,
    required this.onStateTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: stateThemes.length,
        itemBuilder: (context, index) {
          final theme = stateThemes[index];
          return _StateCard(
            theme: theme,
            onTap: () => onStateTap(theme),
          );
        },
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  final StateTheme theme;
  final VoidCallback onTap;

  const _StateCard({
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: theme.colors.map((color) => Color(int.parse('0xFF${color.substring(1)}'))).toList(),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background Pattern
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white.withOpacity(0.1),
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // State Name
                    Text(
                      theme.name,
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Description
                    Text(
                      theme.description,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.white.withOpacity(0.9),
                        height: 1.4,
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Special Craft
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        theme.specialCraft,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Explore Button
                    Row(
                      children: [
                        Text(
                          'Explore Crafts',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppColors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// StateTheme class for reference
class StateTheme {
  final String state;
  final String name;
  final String backgroundImage;
  final List<String> colors;
  final String specialCraft;
  final String description;
  final String heritage;

  StateTheme({
    required this.state,
    required this.name,
    required this.backgroundImage,
    required this.colors,
    required this.specialCraft,
    required this.description,
    required this.heritage,
  });
}