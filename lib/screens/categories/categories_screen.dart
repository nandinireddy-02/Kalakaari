import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../models/product.dart';
import '../../services/dummy_data.dart';
import '../category/category_products_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Product> _allProducts = DummyData.products;
  
  // Dynamic categories from products
  List<Map<String, dynamic>> get _dynamicCategories {
    Map<String, int> categoryCount = {};
    Map<String, IconData> categoryIcons = {
      'Handloom': Icons.web,
      'Metalwork': Icons.construction,
      'Paintings': Icons.palette,
      'Pottery': Icons.emoji_objects,
      'Woodwork': Icons.carpenter,
      'Traditional Jewelry': Icons.diamond,
      'Footwear': Icons.directions_walk,
      'Bamboo Crafts': Icons.eco,
      'Terracotta': Icons.emoji_nature,
    };
    
    // Count products per category
    for (var product in _allProducts) {
      categoryCount[product.category] = (categoryCount[product.category] ?? 0) + 1;
    }
    
    List<Map<String, dynamic>> categories = categoryCount.entries.map((entry) => {
      'name': entry.key,
      'count': entry.value,
      'icon': categoryIcons[entry.key] ?? Icons.category,
      'products': _allProducts.where((p) => p.category == entry.key).toList(),
    }).toList();
    
    categories.sort((a, b) => (b['count'] as int).compareTo(a['count'] as int));
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Categories',
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.darkGrey,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back, color: AppColors.saffron),
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Header Info
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.saffronGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore Craft Categories',
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover authentic handcrafted items organized by traditional craft types',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Color.fromRGBO(AppColors.white.red, AppColors.white.green, AppColors.white.blue, 0.9),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(AppColors.white.red, AppColors.white.green, AppColors.white.blue, 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_dynamicCategories.length} Categories Available',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Categories Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _dynamicCategories.length,
                itemBuilder: (context, index) {
                  final categoryData = _dynamicCategories[index];
                  return _CategoryGridItem(
                    categoryData: categoryData,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductsScreen(
                            categoryName: categoryData['name'],
                            products: categoryData['products'],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _CategoryGridItem extends StatelessWidget {
  final Map<String, dynamic> categoryData;
  final VoidCallback onTap;

  const _CategoryGridItem({
    required this.categoryData,
    required this.onTap,
  });
  
  Color _getCategoryColor() {
    switch (categoryData['name'].toString().toLowerCase()) {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _getCategoryColor(),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(_getCategoryColor().red, _getCategoryColor().green, _getCategoryColor().blue, 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                categoryData['icon'],
                color: AppColors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              categoryData['name'],
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color.fromRGBO(_getCategoryColor().red, _getCategoryColor().green, _getCategoryColor().blue, 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${categoryData['count']} items',
                style: AppTextStyles.bodySmall.copyWith(
                  color: _getCategoryColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}