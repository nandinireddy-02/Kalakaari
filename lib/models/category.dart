class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String image;
  final List<String> subCategories;
  final int productCount;
  final List<String> popularStates;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.image,
    required this.subCategories,
    required this.productCount,
    required this.popularStates,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      image: json['image'] ?? '',
      subCategories: List<String>.from(json['subCategories'] ?? []),
      productCount: json['productCount'] ?? 0,
      popularStates: List<String>.from(json['popularStates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'image': image,
      'subCategories': subCategories,
      'productCount': productCount,
      'popularStates': popularStates,
    };
  }
}

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