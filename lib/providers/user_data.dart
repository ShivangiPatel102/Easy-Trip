import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_logins/local_storage/user_data_storage.dart';

class UserData extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _photoUrl = '';

  String get firstName => _firstName;
  String get email => _email;
  String get lastName => _lastName;

  String get photoUrl => _photoUrl;

  void setPhotoUrl(String url) {
    _photoUrl = url;
    notifyListeners();
  }

// Constructor to load user data during initialization
  UserData() {
    _loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final userData = await UserDataStorage.loadUserData();
    _firstName = userData['firstName'] ?? '';
    _lastName = userData['lastName'] ?? '';
    _email = userData['email'] ?? '';
    
    notifyListeners();
  }

  void setFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  void setUserEmail(String email) {
    _email = email;
    notifyListeners();
  }
}

final userDataProvider = ChangeNotifierProvider<UserData>((ref) {
  return UserData();
});
