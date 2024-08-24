import 'dart:convert';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:social_logins/services/location.dart';
import 'package:social_logins/services/location.dart';
// import 'package:social_logins/providers/booking_data.dart';

Future<Map<String, dynamic>> fetchBookingData() async {
  const String baseUrl =
      'https://us-central1-bookingapp-7775b.cloudfunctions.net/';
  const String getBookingDetailsFunction = 'get_booking_data';

  MyLocation location = MyLocation();
  String? cityName = await location.getLocation();


  final Map<String, dynamic> requestBody = {
    'numberOfItems': 5,
    'category': 'hotels',
    'location': cityName ?? 'Las Vegas',
  };

  final http.Response response = await http.post(
    Uri.parse(baseUrl + getBookingDetailsFunction),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    // Handle the case where the HTTP request fails
    return {"Error ${response.statusCode} - ${response.body}": 0};
  }
}

