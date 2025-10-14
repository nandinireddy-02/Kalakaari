import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';
import '../product/product_detail_screen.dart';

class StateProductsScreen extends StatefulWidget {
  final String stateName;
  final List<Product> products;

  const StateProductsScreen({
    super.key,
    required this.stateName,
    required this.products,
  });

  @override
  State<StateProductsScreen> createState() => _StateProductsScreenState();
}

class _StateProductsScreenState extends State<StateProductsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'All';
  List<Product> _filteredProducts = [];
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _filteredProducts = widget.products;
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  List<String> get _categories {
    Set<String> categories = {'All'};
    for (var product in widget.products) {
      categories.add(product.category);
    }
    return categories.toList();
  }
  
  void _filterProducts(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredProducts = widget.products;
      } else {
        _filteredProducts = widget.products
            .where((product) => product.category == category)
            .toList();
      }
    });
  }
  
  LinearGradient _getStateGradient() {
    switch (widget.stateName) {
      case 'Rajasthan':
        return AppColors.saffronGradient;
      case 'Tamil Nadu':
        return AppColors.maroonGradient;
      case 'Telangana':
        return AppColors.purpleGradient;
      case 'West Bengal':
        return AppColors.greenGradient;
      default:
        return AppColors.saffronGradient;
    }
  }
  
  String _getStateDescription() {
    switch (widget.stateName) {
      case 'Rajasthan':
        return 'Explore the vibrant crafts of the desert kingdom, where royal heritage meets artistic excellence';
      case 'Tamil Nadu':
        return 'Discover the ancient Dravidian craft traditions that have flourished for millennia';
      case 'Telangana':
        return 'Delve into the rich Nizami heritage and royal crafts of the Deccan region';
      case 'West Bengal':
        return 'Experience the cultural renaissance through Bengal\'s timeless artistic traditions';
      default:
        return 'Discover the rich cultural heritage and traditional crafts';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.saffron,
                ),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: _getStateGradient(),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.stateName,
                                  style: AppTextStyles.heading1.copyWith(
                                    color: AppColors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _getStateDescription(),
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: AppColors.white.withOpacity(0.9),
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${widget.products.length} Products Available',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Category Filter
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by Category',
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final category = _categories[index];
                          final isSelected = category == _selectedCategory;
                          
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              _filterProducts(category);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: isSelected ? _getStateGradient() : null,
                                color: isSelected ? null : AppColors.cream,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: isSelected 
                                    ? Colors.transparent 
                                    : AppColors.grey.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                category,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: isSelected 
                                    ? AppColors.white 
                                    : AppColors.darkGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Products Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: FadeTransition(
              opacity: _fadeAnimation,
              child: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ProductCard(
                      product: _filteredProducts[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: _filteredProducts[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: _filteredProducts.length,
                ),
              ),
            ),
          ),
          
          // Bottom Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}