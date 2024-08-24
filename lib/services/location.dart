import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation {
  Future<String> _getCityName(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    String cityName = placemarks.first.locality ?? "";
    return cityName;
  }

  Future<String?> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle denied permission
    } else if (permission == LocationPermission.deniedForever) {
      // Handle denied forever permission
    } else {
      // Permission granted, get location
      Position position = await Geolocator.getCurrentPosition();
      print("Current location: ${position.latitude}, ${position.longitude}");

      // Now, you can use the location data to get the city name or send it to the API for hotel data fetching
      String cityName =
          await _getCityName(position.latitude, position.longitude);
      print("City Name: $cityName");
      return cityName;

      // Call your API with the cityName to fetch hotel data
      // fetchHotelData(cityName);
    }
  }
}
