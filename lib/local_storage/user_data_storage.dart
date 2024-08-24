// import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataStorage {
  static const String _keyFirstName = 'firstName';
  static const String _keyLastName = 'lastName';
  static const String _keyEmail = 'email';

  // Save user data to SharedPreferences
  static Future<void> saveUserData(String firstName, String lastName, String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyFirstName, firstName);
    prefs.setString(_keyLastName, lastName);
    prefs.setString(_keyEmail, email);
  }

  // Retrieve user data from SharedPreferences
  static Future<Map<String, String?>> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString(_keyFirstName);
    final lastName = prefs.getString(_keyLastName);
    final email = prefs.getString(_keyEmail);

    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}