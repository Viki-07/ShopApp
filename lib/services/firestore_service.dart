// services/firestore_service.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> getLikedProducts() async {
    print('exec');
    QuerySnapshot querySnapshot =
        await _firestore.collection('liked_products').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> addLikedProduct(String productId) async {
    await _firestore.collection('liked_products').add({
      'productId': productId,
    });
  }

  Future<void> removeLikedProduct(String likedProductId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('liked_products')
        .where('productId', isEqualTo: likedProductId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await _firestore
          .collection('liked_products')
          .doc(querySnapshot.docs[0].id)
          .delete();
    } else {
      print('No matching document found for id: $likedProductId');
    }
  }

  Future<List<Map<String, dynamic>>> getCartProducts() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('cart_products').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> addCartProduct(String productId, int quantity) async {
    await _firestore.collection('cart_products').add({
      'productId': productId,
      'quantity': quantity,
    });
  }

  Future<void> updateCartProduct(String cartProductId, int newQuantity) async {
    await _firestore.collection('cart_products').doc(cartProductId).update({
      'quantity': newQuantity,
    });
  }

  Future<void> checkoutCartProduct() async {
    QuerySnapshot cartSnapshot =
        await _firestore.collection('cart_products').get();

    for (QueryDocumentSnapshot document in cartSnapshot.docs) {
      await _firestore.collection('cart_products').doc(document.id).delete();
    }
  }

  Future<void> removeCartProduct(String cartProductId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('cart_products')
        .where('productId', isEqualTo: cartProductId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await _firestore.collection('cart_products').doc(document.id).delete();
      }
    } else {
      print('No matching documents found for productId: $cartProductId');
    }
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('order_products').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> addOrder(String orderId, List<Map<String, dynamic>> orderItems,
      String totalPrice, String orderDate) async {
    await _firestore.collection('order_products').add({
      'orderId': orderId,
      'orderPrice': totalPrice,
      'orderItems': orderItems,
      'orderDate': orderDate,
    });
  }

  Future<Map<String, dynamic>> getUserData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('user_Data').get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data() as Map<String, dynamic>;
    } else {
      return {}; 
    }
  }

  Future<void> addUserData(
      String userName, String email, String profileImage) async {
    await _firestore.collection('user_Data').add({
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
    });
  }

  Future<void> updateUserData(
      String newUserName, String newEmail, String imgUrl) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('user_Data').get();

    if (querySnapshot.docs.isNotEmpty) {
      String documentId = querySnapshot.docs.first.id;

      await FirebaseFirestore.instance
          .collection('user_Data')
          .doc(documentId)
          .update(
              {'userName': newUserName, 'email': newEmail, 'imageUrl': imgUrl});
    } else {
    }
  }

  Future<String> uploadProfileImage(String imgPath) async {
    print(imgPath);
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImagetoUpload = referenceDirImages.child(imgPath);
    try {
      await referenceImagetoUpload.putFile(File(imgPath));
      return await referenceImagetoUpload.getDownloadURL();
    } catch (error) {}
    return '';
  }

  Future<Map<String, dynamic>> getAddress() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('shipping_add').get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data() as Map<String, dynamic>;
    } else {
      return {}; 
    }
  }

  Future<void> addAddress(String add1, String add2, String city, String state,
      String country, String pincode) async {
    await _firestore.collection('shipping_add').add({
      'add1': add1,
      'add2': add2,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode
    });
  }

  Future<void> updateAddress(String add1, String add2, String city,
      String state, String country, String pincode) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('shipping_add').get();

    if (querySnapshot.docs.isNotEmpty) {
      String documentId = querySnapshot.docs.first.id;

      await FirebaseFirestore.instance
          .collection('shipping_add')
          .doc(documentId)
          .update({
        'add1': add1,
        'add2': add2,
        'city': city,
        'state': state,
        'country': country,
        'pincode': pincode
      });
    } else {
    }
  }

  Future<Map<String, dynamic>> getCard() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('card_Data').get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data() as Map<String, dynamic>;
    } else {
      return {}; 
    }
  }

  Future<void> addCard(String cardNumber, String cardHolderName,
      String cardExpiryDate, String cardCvv) async {
    await _firestore.collection('card_Data').add({
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'cardExpiryDate': cardExpiryDate,
      'cardCvv': cardCvv
    });
  }

  Future<void> updateCard(String cardNumber, String cardHolderName,
      String cardExpiryDate, String cardCvv) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('card_Data').get();

    if (querySnapshot.docs.isNotEmpty) {
      String documentId = querySnapshot.docs.first.id;

      await FirebaseFirestore.instance
          .collection('card_Data')
          .doc(documentId)
          .update({
        'cardNumber': cardNumber,
        'cardHolderName': cardHolderName,
        'cardExpiryDate': cardExpiryDate,
        'cardCvv': cardCvv
      });
    } else {
      
    }
  }
}
