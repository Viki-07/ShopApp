import 'package:flutter/material.dart';
import 'package:shop_example/services/firestore_service.dart';

class OrderProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> orderProduct = [];
    bool _isLoading = false; 

  List<Map<String, dynamic>> get _orderProduct => orderProduct;
    bool get isLoading => _isLoading; 

  Future<void> addOrderProduct(String orderId,
      List<Map<String, dynamic>> orderItems, String totalPrice,String orderDate) async {
    orderProduct.add({
      'orderId': orderId,
      'orderItems': orderItems,
      'orderPrice': totalPrice,
      'orderDate':orderDate,
    });
    await _firestoreService.addOrder(orderId, orderItems, totalPrice,orderDate);
    notifyListeners();
  }
  Future<void> fetchOrders() async {
    _isLoading = true; 
    notifyListeners();

    try {
      orderProduct = await _firestoreService.getOrders();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
