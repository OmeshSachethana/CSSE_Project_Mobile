import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _products = [];

  double _subtotal = 0.0;
  double _tax = 0.0;
  double _total = 0.0;

  CartModel() {
    _calculateTotal();
  }

  List<Map<String, dynamic>> get products => _products;
  double get subtotal => _subtotal;
  double get tax => _tax;
  double get total => _total;

  void _calculateTotal() {
    double subtotal = 0.0;
    for (var product in _products) {
      subtotal += product['price'] * (product['quantity']);
    }
    double tax = subtotal * 0.05;
    double total = subtotal + tax;

    _subtotal = subtotal;
    _tax = tax;
    _total = total;

    notifyListeners();
  }

  void incrementQuantity(int index) {
    _products[index]['quantity']++;
    _calculateTotal();
  }

  void decrementQuantity(int index) {
    if (_products[index]['quantity'] > 1) {
      _products[index]['quantity']--;
      _calculateTotal();
    }
  }

  void removeProduct(int index) {
    _products.removeAt(index);
    _calculateTotal();
  }

  void addProduct(Map<String, dynamic> product) {
    // new method to add a product
    product['quantity'] = 1; // set the initial quantity
    _products.add(product);
    _calculateTotal();
  }

  void clearCart() {
    _products.clear();
    _calculateTotal();
  }
}
