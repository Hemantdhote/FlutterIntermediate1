import 'package:flutter/foundation.dart';
import 'package:intermediate_assignment1/services/product_service.dart';
import '../models/product_modal.dart';

class CartEntry {
  final Product product;
  final int quantity;

  CartEntry({required this.product, required this.quantity});
  CartEntry copyWith({int? quantity}) {
    return CartEntry(product: product, quantity: quantity ?? this.quantity);
  }
}

class ProductController extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> products = [];
  final Map<int, CartEntry> _cart = {};

  bool isLoading = false;
  String? errorMessage;

  List<CartEntry> get cartItems => _cart.values.toList();

  int get cartCount => _cart.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _cart.values.fold(
    0.0,
    (sum, item) => sum + item.product.price * item.quantity,
  );

  Future<void> fetchProducts() async {
    if (isLoading || products.isNotEmpty) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await _service.fetchProducts();
    } catch (e, stackTrace) {
      debugPrint('Error fetching products: $e');
      debugPrint('Stack trace: $stackTrace');

      errorMessage = 'Unable to load products. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    if (_cart.containsKey(product.id)) {
      final entry = _cart[product.id]!;
      _cart[product.id] = entry.copyWith(quantity: entry.quantity + 1);
    } else {
      _cart[product.id] = CartEntry(product: product, quantity: 1);
    }

    notifyListeners();
  }

  void increaseQuantity(int productId) {
    final entry = _cart[productId];
    if (entry == null) return;
    

    _cart[productId] = entry.copyWith(quantity: entry.quantity + 1);

    notifyListeners();
  }

  void decreaseQuantity(int productId) {
    final entry = _cart[productId];
    if (entry == null) return;

    if (entry.quantity <= 1) {
      _cart.remove(productId);
    } else {
      _cart[productId] = entry.copyWith(quantity: entry.quantity - 1);
    }

    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cart.remove(productId);
    notifyListeners();
  }
}
