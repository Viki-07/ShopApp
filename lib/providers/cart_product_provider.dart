import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_example/services/firestore_service.dart';
import 'order_provider.dart';

class CartProductProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _cartProducts = [];
  bool _isLoading = false; 

  List<Map<String, dynamic>> get cartProducts => _cartProducts;
  bool get isLoading => _isLoading; 

  Future<void> addCartProduct(String productId, int quantity) async {
    await _firestoreService.addCartProduct(productId, quantity);
    _cartProducts.add({'productId': productId, 'quantity': quantity});
    notifyListeners();
  }

  Future<void> updateCartProduct(String cartProductId, int newQuantity) async {
    await _firestoreService.updateCartProduct(cartProductId, newQuantity);
    int index = _cartProducts
        .indexWhere((product) => product['productId'] == cartProductId);
    if (index != -1) {
      _cartProducts[index]['quantity'] = newQuantity;
      notifyListeners();
    }
  }

  Future<void> removeCartProduct(String cartProductId) async {
    await _firestoreService.removeCartProduct(cartProductId);
    _cartProducts
        .removeWhere((product) => product['productId'] == cartProductId);
    notifyListeners();
  }

  Future<void> checkoutCartProduct() async {
    await _firestoreService.checkoutCartProduct();

    _cartProducts.clear();
    notifyListeners();
  }

  Future<void> fetchCartProducts() async {
    _isLoading = true; 
    notifyListeners();

    try {
      _cartProducts = await _firestoreService.getCartProducts();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
