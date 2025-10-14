import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';
import '../product/product_detail_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;
  final List<Product> products;

  const CategoryProductsScreen({
    super.key,
    required this.categoryName,
    required this.products,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final ScrollController _scrollController = ScrollController();
  String _selectedState = 'All';
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
  
  List<String> get _states {
    Set<String> states = {'All'};
    for (var product in widget.products) {
      states.add(product.state);
    }
    return states.toList();
  }
  
  void _filterProducts(String state) {
    setState(() {
      _selectedState = state;
      if (state == 'All') {
        _filteredProducts = widget.products;
      } else {
        _filteredProducts = widget.products
            .where((product) => product.state == state)
            .toList();
      }
    });
  }
  
  IconData _getCategoryIcon() {
    switch (widget.categoryName.toLowerCase()) {
      case 'handloom':
        return Icons.web;
      case 'metalwork':
        return Icons.construction;
      case 'paintings':
        return Icons.palette;
      case 'pottery':
        return Icons.emoji_objects;
      case 'woodwork':
        return Icons.carpenter;
      case 'traditional jewelry':
        return Icons.diamond;
      case 'footwear':
        return Icons.directions_walk;
      case 'bamboo crafts':
        return Icons.eco;
      case 'terracotta':
        return Icons.emoji_nature;
      default:
        return Icons.category;
    }
  }
  
  Color _getCategoryColor() {
    switch (widget.categoryName.toLowerCase()) {
      case 'handloom':
        return Colors.purple;
      case 'metalwork':
        return Colors.grey[700]!;
      case 'paintings':
        return Colors.orange;
      case 'pottery':
        return Colors.brown;
      case 'woodwork':
        return Colors.green[700]!;
      case 'traditional jewelry':
        return Colors.pink;
      case 'footwear':
        return Colors.blue[700]!;
      case 'bamboo crafts':
        return Colors.green;
      case 'terracotta':
        return Colors.deepOrange;
      default:
        return AppColors.saffron;
    }
  }
  
  LinearGradient _getCategoryGradient() {
    Color color = _getCategoryColor();
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color,
        color.withOpacity(0.7),
      ],
    );
  }
  
  String _getCategoryDescription() {
    switch (widget.categoryName.toLowerCase()) {
      case 'handloom':
        return 'Traditional hand-woven textiles showcasing ancient weaving techniques and regional patterns';
      case 'metalwork':
        return 'Exquisite metal crafts including brass, copper, and silver work from master artisans';
      case 'paintings':
        return 'Traditional art forms including miniature paintings, folk art, and contemporary interpretations';
      case 'pottery':
        return 'Clay artistry from various regions, featuring functional and decorative ceramic pieces';
      case 'woodwork':
        return 'Hand-carved wooden artifacts showcasing intricate designs and traditional craftsmanship';
      case 'traditional jewelry':
        return 'Authentic Indian jewelry with traditional designs, stones, and metalwork';
      case 'footwear':
        return 'Handcrafted traditional shoes and sandals with regional embroidery and designs';
      case 'bamboo crafts':
        return 'Eco-friendly bamboo products showcasing sustainable craftsmanship and innovative designs';
      case 'terracotta':
        return 'Earthen crafts and sculptures representing ancient pottery traditions and artistic expressions';
      default:
        return 'Discover authentic handcrafted items from skilled Indian artisans';
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
                  gradient: _getCategoryGradient(),
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
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        _getCategoryIcon(),
                                        color: AppColors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        widget.categoryName,
                                        style: AppTextStyles.heading1.copyWith(
                                          color: AppColors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  _getCategoryDescription(),
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
          
          // State Filter
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by State',
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _states.length,
                        itemBuilder: (context, index) {
                          final state = _states[index];
                          final isSelected = state == _selectedState;
                          
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              _filterProducts(state);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: isSelected ? _getCategoryGradient() : null,
                                color: isSelected ? null : AppColors.cream,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: isSelected 
                                    ? Colors.transparent 
                                    : AppColors.grey.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                state,
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