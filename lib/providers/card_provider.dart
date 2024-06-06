import 'package:flutter/material.dart';
import 'package:shop_example/services/firestore_service.dart';

class CardProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic> _userCard = {};
  bool _isLoading = false;

  Map<String, dynamic> get userCard => _userCard;
  bool get isLoading => _isLoading;

  Future<void> addCard(String cardNumber, String cardHolderName,
      String cardExpiryDate, String cardCvv) async {
    if (_userCard.isEmpty) {
  
      await _firestoreService.addCard(
          cardNumber, cardHolderName, cardExpiryDate, cardCvv);
      _userCard.addAll({
        'cardNumber': cardNumber,
        'cardHolderName': cardHolderName,
        'cardExpiryDate': cardExpiryDate,
        'cardCvv': cardCvv
      });
      notifyListeners();
    }
  }

  Future<void> updateCard(String cardNumber, String cardHolderName,
      String cardExpiryDate, String cardCvv) async {
    await _firestoreService.updateCard(
        cardNumber, cardHolderName, cardExpiryDate, cardCvv);
    _userCard.update('cardNumber', (value) => cardNumber);
    _userCard.update('cardHolderName', (value) => cardHolderName);
    _userCard.update('cardExpiryDate', (value) => cardExpiryDate);
    _userCard.update('cardCvv', (value) => cardCvv);
    notifyListeners();
  }

  Future<void> fetchCardData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _userCard = await _firestoreService.getCard();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
