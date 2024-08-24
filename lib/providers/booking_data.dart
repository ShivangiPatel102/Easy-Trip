import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingData extends ChangeNotifier {
  List<dynamic> _bookingData = [];

  List<dynamic> get bookingData => _bookingData;
  
  void setBookingData(List<dynamic> bookingData) {
    _bookingData = bookingData;
    notifyListeners();
  }
  
}


final bookingDataProvider = ChangeNotifierProvider<BookingData>((ref) {
  return BookingData();
});


//   String _nameOfHotel = '';
//   String _locationOfHotel = '';
//   String _priceOfHotel = '';
//   List _amenities = [];

//   String get nameOfHotelOfHotel => _nameOfHotel;
//   String get locationOfHotel => _locationOfHotel;
//   String get priceOfHotel => _priceOfHotel;
//   List get amenities => _amenities;

// // Constructor to load user data during initialization

//   // Load booking data from

//   void setNameOfHotel(String nameOfHotel) {
//     _nameOfHotel = nameOfHotel;
//     notifyListeners();
//   }

//   void setPriceOfHotel(String priceOfHotel) {
//     _priceOfHotel = priceOfHotel;
//     notifyListeners();
//   }

//   void setLocationOfHotel(String locationOfHotel) {
//     _locationOfHotel = locationOfHotel;
//     notifyListeners();
//   }

//   void setAmenties(List amenities) {
//     _amenities = amenities;
//     notifyListeners();
//   }
// }