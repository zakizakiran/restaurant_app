class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Map<String, dynamic>> categories;
  final Map<String, dynamic> menus;
  final double rating;
  final List<Map<String, dynamic>> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categories: List<Map<String, dynamic>>.from(json['categories']),
      menus: Map<String, dynamic>.from(json['menus']),
      rating: json['rating'].toDouble(),
      customerReviews: List<Map<String, dynamic>>.from(json['customerReviews']),
    );
  }
}
