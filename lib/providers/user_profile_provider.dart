import 'package:flutter/material.dart';
import 'package:shop_example/services/firestore_service.dart';

class UserProfileProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic> _userProfile = {};
  bool _isLoading = false;

  Map<String, dynamic> get userProfile => _userProfile;
  bool get isLoading => _isLoading;

  Future<void> addUserData(String userName, String email, String profileImage) async {
    if (_userProfile.isEmpty) {

      await _firestoreService.addUserData(userName, email, profileImage);
      _userProfile.addAll({'userName': userName, 'email': email, 'imageUrl': profileImage});
      print(userProfile);
      notifyListeners();
    }
  }

  Future<void> updateUserData(String userName, String email,String profileImage) async {
    await _firestoreService.updateUserData(userName, email,profileImage);
    _userProfile.update('userName', (value) => userName);
    _userProfile.update('email', (value) => email);
    _userProfile.update('imageUrl',(value)=>profileImage);
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    _isLoading = true; 
    notifyListeners();

    try {
      _userProfile = await _firestoreService.getUserData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> uploadProfileImage(String imagePath) async {
    String imageUrl=await _firestoreService.uploadProfileImage(imagePath);
    return imageUrl;

  }
}
