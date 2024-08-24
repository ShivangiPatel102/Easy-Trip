import 'package:firebase_analytics/firebase_analytics.dart';


// Create an instance of Firebase Analytics
final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

// Log event when a hotel is clicked
void logHotelClickEvent(String hotelName) {
  _analytics.logEvent(
    name: 'hotel_click',
    parameters: {'hotel_name': hotelName},
  );
}

// Log event when the book button is clicked on a hotel's detail page
void logBookButtonClickEvent(String hotelName) {
  _analytics.logEvent(
    name: 'book_button_click',
    parameters: {'hotel_name': hotelName},
  );
}
