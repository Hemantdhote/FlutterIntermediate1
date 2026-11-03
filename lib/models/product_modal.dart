
class Product{
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.thumbnail
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json['id'] as int, 
      title: json['title'] as String, 
      category: json['category'] as String, 
      price: (json['price'] as num).toDouble(), 
      rating: (json['rating'] as num).toDouble(), 
      thumbnail: json['thumbnail'] as String
      );
  }
}