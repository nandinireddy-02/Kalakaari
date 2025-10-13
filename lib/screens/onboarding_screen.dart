import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/colors.dart';
import '../utils/theme.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: 'Discover Authentic Indian Crafts',
      description: 'Explore handmade treasures from skilled artisans across India. Each piece tells a story of tradition and heritage.',
      icon: '🏺',
      gradient: AppColors.saffronGradient,
    ),
    OnboardingItem(
      title: 'Support Local Artisans',
      description: 'Connect directly with craftspeople from different states. Your purchase helps preserve traditional art forms.',
      icon: '🤝',
      gradient: AppColors.greenGradient,
    ),
    OnboardingItem(
      title: 'Cultural Shopping Experience',
      description: 'Shop by states, learn artisan stories, and become part of India\'s cultural heritage preservation.',
      icon: '🛍️',
      gradient: AppColors.maroonGradient,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Page View
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingItems.length,
            itemBuilder: (context, index) {
              return _buildOnboardingPage(_onboardingItems[index]);
            },
          ),
          
          // Skip Button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _navigateToLogin,
              child: Text(
                'Skip',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          // Bottom Controls
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Page Indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _onboardingItems.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.white,
                    dotColor: AppColors.white.withOpacity(0.5),
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Navigation Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _currentPage == _onboardingItems.length - 1
                        ? _navigateToLogin
                        : _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: _onboardingItems[_currentPage].gradient.colors.first,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentPage == _onboardingItems.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: _onboardingItems[_currentPage].gradient.colors.first,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOnboardingPage(OnboardingItem item) {
    return Container(
      decoration: BoxDecoration(gradient: item.gradient),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              
              // Icon
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    item.icon,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Title
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Description
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.white.withOpacity(0.9),
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
  
  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  
  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String icon;
  final LinearGradient gradient;
  
  OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}