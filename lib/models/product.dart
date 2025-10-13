class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final String category;
  final String state;
  final String artisanId;
  final String artisanName;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final bool isAvailable;
  final int stockCount;
  final String heritage;
  final Map<String, dynamic> specifications;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.state,
    required this.artisanId,
    required this.artisanName,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.isAvailable,
    required this.stockCount,
    required this.heritage,
    required this.specifications,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      state: json['state'] ?? '',
      artisanId: json['artisanId'] ?? '',
      artisanName: json['artisanName'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      isAvailable: json['isAvailable'] ?? true,
      stockCount: json['stockCount'] ?? 0,
      heritage: json['heritage'] ?? '',
      specifications: json['specifications'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'category': category,
      'state': state,
      'artisanId': artisanId,
      'artisanName': artisanName,
      'rating': rating,
      'reviewCount': reviewCount,
      'tags': tags,
      'isAvailable': isAvailable,
      'stockCount': stockCount,
      'heritage': heritage,
      'specifications': specifications,
    };
  }
}