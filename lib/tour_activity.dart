class TourActivity {
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  TourActivity({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory TourActivity.fromJson(Map<String, dynamic> json) {
    return TourActivity(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
    );
  }
}