import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../models/product.dart';
import '../../models/category.dart';
import '../../services/dummy_data.dart';
import '../../widgets/product_card.dart';
import '../../widgets/category_card.dart';
import '../categories/categories_screen.dart';
import '../product/product_detail_screen.dart';
import '../state/state_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  int _currentBottomNavIndex = 0;
  final List<Product> _trendingProducts = DummyData.products;
  final List<Category> _categories = DummyData.categories;
  
  // Page controllers for each state section
  final Map<String, PageController> _statePageControllers = {
    'Rajasthan': PageController(),
    'Tamil Nadu': PageController(),
    'Telangana': PageController(),
    'West Bengal': PageController(),
  };
  
  // Current page index for each state
  final Map<String, int> _currentStatePages = {
    'Rajasthan': 0,
    'Tamil Nadu': 0,
    'Telangana': 0,
    'West Bengal': 0,
  };
  
  // Number of products to show per page
  static const int _productsPerPage = 3;
  
  // Filter settings
  bool _showOnlyAvailable = false;
  
  List<Product> get _filteredProducts {
    List<Product> products = _trendingProducts;
    
    if (_showOnlyAvailable) {
      products = products.where((product) => product.isAvailable).toList();
    }
    
    return products;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    // Dispose page controllers
    for (var controller in _statePageControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
  
  void _navigateToStateProducts(String stateName, List<Product> products) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StateProductsScreen(
          stateName: stateName,
          products: products,
        ),
      ),
    );
  }
  
  List<Product> _getFilteredStateProducts(String state) {
    List<Product> stateProducts = _trendingProducts.where((p) => p.state == state).toList();
    
    if (_showOnlyAvailable) {
      stateProducts = stateProducts.where((product) => product.isAvailable).toList();
    }
    
    return stateProducts;
  }
  
  Widget _buildFilterHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Filters',
            style: AppTextStyles.heading3,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _showOnlyAvailable ? AppColors.saffron : AppColors.cream,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.saffron.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: _showOnlyAvailable ? AppColors.white : AppColors.saffron,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Available Only',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: _showOnlyAvailable ? AppColors.white : AppColors.saffron,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showOnlyAvailable = !_showOnlyAvailable;
                  });
                  HapticFeedback.lightImpact();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.saffron,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.filter_alt,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter Products',
                      style: AppTextStyles.heading3,
                    ),
                    const SizedBox(height: 20),
                    
                    // Availability Filter
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.saffron.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.inventory_2,
                            color: AppColors.saffron,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Show Available Products Only',
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Filter products that are in stock for your expo',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _showOnlyAvailable,
                            onChanged: (value) {
                              setModalState(() {
                                _showOnlyAvailable = value;
                              });
                              setState(() {
                                _showOnlyAvailable = value;
                              });
                              HapticFeedback.lightImpact();
                            },
                            activeColor: AppColors.saffron,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Stats
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: AppColors.saffronGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${_trendingProducts.length}',
                                style: AppTextStyles.heading2.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                'Total Products',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: AppColors.white.withOpacity(0.3),
                          ),
                          Column(
                            children: [
                              Text(
                                '${_trendingProducts.where((p) => p.isAvailable).length}',
                                style: AppTextStyles.heading2.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                'Available',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Close Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.saffron,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Apply Filters',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Search
                _buildHeader(),
                
                // Categories Grid
                _buildCategoriesSection(),
                
                // State-wise Carousels
                _buildStateCarousels(),
                
                // Trending Products
                _buildTrendingSection(),
                
                // Bottom Spacing
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cream, AppColors.white],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting and Profile
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'नमस्ते! 🙏',
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.saffron,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Discover Indian Crafts',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.saffron,
                    child: Icon(
                      Icons.person,
                      color: AppColors.white,
                      size: 28,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.deepGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for crafts, artisans, states...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.grey,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.saffron,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.tune,
                    color: AppColors.saffron,
                  ),
                  onPressed: () {
                    _showFilterBottomSheet();
                    HapticFeedback.lightImpact();
                  },
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shop by Category',
                style: AppTextStyles.heading3,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
                child: Text(
                  'See All',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.saffron,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return CategoryCard(
                category: category,
                onTap: () {
                  HapticFeedback.lightImpact();
                  // TODO: Navigate to category products
                },
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildStateCarousels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            'Explore by States',
            style: AppTextStyles.heading3,
          ),
        ),
        
        // Filter Header
        _buildFilterHeader(),
        
        const SizedBox(height: 20),
        
        // Rajasthan Section
        _buildStateSection(
          'Rajasthan - Royal Crafts',
          'Desert kingdom\'s vibrant traditions',
          AppColors.saffronGradient,
          _getFilteredStateProducts('Rajasthan'),
        ),
        
        const SizedBox(height: 30),
        
        // Tamil Nadu Section
        _buildStateSection(
          'Tamil Nadu - Temple Arts',
          'Ancient Dravidian craft heritage',
          AppColors.maroonGradient,
          _getFilteredStateProducts('Tamil Nadu'),
        ),
        
        const SizedBox(height: 30),
        
        // Telangana Section
        _buildStateSection(
          'Telangana - Nizami Heritage',
          'Royal crafts from the land of Nizams',
          AppColors.purpleGradient,
          _getFilteredStateProducts('Telangana'),
        ),
        
        const SizedBox(height: 30),
        
        // West Bengal Section
        _buildStateSection(
          'West Bengal - Cultural Hub',
          'Rich artistic traditions of Bengal',
          AppColors.greenGradient,
          _getFilteredStateProducts('West Bengal'),
        ),
      ],
    );
  }
  
  Widget _buildStateSection(
    String title,
    String subtitle,
    LinearGradient gradient,
    List<Product> products,
  ) {
    if (products.isEmpty) {
      products = _trendingProducts.take(3).toList(); // Fallback to show some products
    }
    
    // Extract state name from title for controllers
    String stateName = title.split(' - ')[0];
    int currentPage = _currentStatePages[stateName] ?? 0;
    PageController pageController = _statePageControllers[stateName]!;
    
    // Calculate total pages
    int totalPages = (products.length / _productsPerPage).ceil();
    bool canNavigateLeft = currentPage > 0;
    bool canNavigateRight = currentPage < totalPages - 1;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.heading3.copyWith(
                        color: AppColors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation indicators
              if (totalPages > 1) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${currentPage + 1} / $totalPages',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  _navigateToStateProducts(stateName, products);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Products with navigation
        Stack(
          children: [
            SizedBox(
              height: 240,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentStatePages[stateName] = page;
                  });
                },
                itemCount: totalPages,
                itemBuilder: (context, pageIndex) {
                  int startIndex = pageIndex * _productsPerPage;
                  int endIndex = (startIndex + _productsPerPage).clamp(0, products.length);
                  List<Product> pageProducts = products.sublist(startIndex, endIndex);
                  
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    itemCount: pageProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: pageProducts[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: pageProducts[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            
            // Left Navigation Arrow
            if (canNavigateLeft)
              Positioned(
                left: 20,
                top: 80,
                child: GestureDetector(
                  onTap: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    HapticFeedback.lightImpact();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
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
                      Icons.chevron_left,
                      color: AppColors.saffron,
                      size: 24,
                    ),
                  ),
                ),
              ),
            
            // Right Navigation Arrow
            if (canNavigateRight)
              Positioned(
                right: 20,
                top: 80,
                child: GestureDetector(
                  onTap: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    HapticFeedback.lightImpact();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
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
                      Icons.chevron_right,
                      color: AppColors.saffron,
                      size: 24,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            'Trending Now 🔥',
            style: AppTextStyles.heading3,
          ),
        ),
        
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _filteredProducts.length,
            itemBuilder: (context, index) {
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
          ),
        ),
      ],
    );
  }
  
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
          HapticFeedback.lightImpact();
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.saffron,
        unselectedItemColor: AppColors.grey,
        selectedLabelStyle: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.bodySmall,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}