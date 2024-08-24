import 'dart:convert';
import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_logins/providers/user_data.dart';

class UpdateProfilePhoto {
  static Future<void> setProfilePhoto(
      File imageFile, BuildContext context, WidgetRef ref) async {
    // Read the image file as bytes
    List<int> imageBytes = await imageFile.readAsBytes();

    // Encode the image bytes as base64 string
    String base64Image = base64Encode(imageBytes);
    ref.read(userDataProvider).setPhotoUrl(base64Image);

    // Update the user's profile image in Firestore
    // User user = FirebaseAuth.instance.currentUser!;
    // if (user != null) {
    //   await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
    //     'profileImage': base64Image,
    //   });
  }
}
