class Artisan {
  final String id;
  final String name;
  final String profileImage;
  final String coverImage;
  final String state;
  final String city;
  final String bio;
  final String story;
  final List<String> specializations;
  final double rating;
  final int reviewCount;
  final int yearsOfExperience;
  final String heritage;
  final List<String> awards;
  final List<String> productIds;
  final Map<String, String> socialLinks;
  final bool isVerified;
  final DateTime joinedDate;

  Artisan({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.coverImage,
    required this.state,
    required this.city,
    required this.bio,
    required this.story,
    required this.specializations,
    required this.rating,
    required this.reviewCount,
    required this.yearsOfExperience,
    required this.heritage,
    required this.awards,
    required this.productIds,
    required this.socialLinks,
    required this.isVerified,
    required this.joinedDate,
  });

  factory Artisan.fromJson(Map<String, dynamic> json) {
    return Artisan(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profileImage'] ?? '',
      coverImage: json['coverImage'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      bio: json['bio'] ?? '',
      story: json['story'] ?? '',
      specializations: List<String>.from(json['specializations'] ?? []),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      heritage: json['heritage'] ?? '',
      awards: List<String>.from(json['awards'] ?? []),
      productIds: List<String>.from(json['productIds'] ?? []),
      socialLinks: Map<String, String>.from(json['socialLinks'] ?? {}),
      isVerified: json['isVerified'] ?? false,
      joinedDate: DateTime.parse(json['joinedDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'state': state,
      'city': city,
      'bio': bio,
      'story': story,
      'specializations': specializations,
      'rating': rating,
      'reviewCount': reviewCount,
      'yearsOfExperience': yearsOfExperience,
      'heritage': heritage,
      'awards': awards,
      'productIds': productIds,
      'socialLinks': socialLinks,
      'isVerified': isVerified,
      'joinedDate': joinedDate.toIso8601String(),
    };
  }
}