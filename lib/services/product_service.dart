import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_modal.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse("http://dummyjson.com/products?limit=20");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final products = data['products'] as List<dynamic>;

      return products.map((item)=>Product.fromJson(item as Map<String,dynamic>,),).toList();
    }

    throw Exception("failed to fetch the products : ${response.statusCode}");
  }
}