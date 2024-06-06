// providers/liked_product_provider.dart
import 'package:flutter/material.dart';
import 'package:shop_example/services/firestore_service.dart';


class LikedProductProvider extends ChangeNotifier {
   final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _likedProducts = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get likedProducts => _likedProducts;
  bool get isLoading => _isLoading;

  Future<void> addLikedProduct(String productId) async {
    await _firestoreService.addLikedProduct(productId);
    _likedProducts.add({'productId': productId});
    print(likedProducts.length);
    notifyListeners();
  }

  Future<void> removeLikedProduct(String likedProductId) async {
    await _firestoreService.removeLikedProduct(likedProductId);
    _likedProducts.removeWhere((likedProducts) => likedProducts['productId'] == likedProductId);
    print(likedProducts.length);
    notifyListeners();
  }

  Future<void> fetchLikedProducts() async {
  try {
    _isLoading = true;
    notifyListeners();

    _likedProducts = await _firestoreService.getLikedProducts();
  } catch (error) {
    print('Error fetching liked products: $error');
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
}
