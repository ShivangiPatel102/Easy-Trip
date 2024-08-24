import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
  }

  void handleNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received a notification: ${message.notification?.title}");
    });
  }
}
