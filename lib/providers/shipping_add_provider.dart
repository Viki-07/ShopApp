import 'package:flutter/material.dart';
import 'package:shop_example/services/firestore_service.dart';

class ShippingAddProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic> _shippingAdd = {};
  bool _isLoading = false;

  Map<String, dynamic> get shippingAdd => _shippingAdd;
  bool get isLoading => _isLoading;

   Future<void> addAddress(String add1, String add2, String city,String state,String country,String pincode) async {
    if (shippingAdd.isEmpty) {
     
      await _firestoreService.addAddress(add1,add2,city,state,country,pincode);

      shippingAdd.addAll({'add1':add1,'add2':add2,'city':city,'state':state,'country':country,'pincode':pincode});
      notifyListeners();
    }
  }

  Future<void> updateAddress(String add1, String add2, String city,String state,String country,String pincode) async {
    await _firestoreService.updateAddress(add1,add2,city,state,country,pincode);
    shippingAdd.update('add1', (value) => add1);
    shippingAdd.update('add2', (value) => add2);
    shippingAdd.update('city', (value) => city);
    shippingAdd.update('state', (value) => state);
    shippingAdd.update('country', (value) => country);
    shippingAdd.update('pincode', (value) => pincode);

    notifyListeners();
  }

  Future<void> fetchAddress() async {
    _isLoading = true; 
    notifyListeners();

    try {
      _shippingAdd = await _firestoreService.getAddress();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
}
