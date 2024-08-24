import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:social_logins/constants.dart';
import 'package:social_logins/firebase_options.dart';
import 'package:social_logins/pages/booking_page.dart';
import 'package:social_logins/pages/current_screen.dart';
import 'package:social_logins/pages/home_page.dart';
import 'package:social_logins/pages/payment_page.dart';
import 'package:social_logins/services/notification_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await dotenv.load(fileName: 'assets/.env');
  try {
    await MobileAds.instance.initialize();
  } on Exception catch (e) {
    throw e;
  }
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } on Exception catch (e) {
    throw e;
  }

  // Initializing Firebase Messaging
  try {
    final notificationHandler = NotificationHandler();
    await notificationHandler.initialize();
  } on Exception catch (e) {
    throw e;
  }

  // stripe payment
  try {
    Stripe.publishableKey = '${dotenv.env['STRIPE_PUBLISHABLE_KEY']}';
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
  } on Exception catch (e) {
    throw e;
  }

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

ThemeData myTheme = ThemeData(
    primaryColor: Color(0xFF1d2725), // Main color for app bars, buttons, etc.

    scaffoldBackgroundColor: Color(0xFFf4f5f7),
    // scaffoldBackgroundColor: Colors.yellow.withOpacity(0.1),
    fontFamily: 'NoirPro' // Color for widgets like filter chips
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
     
      theme: myTheme,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => CurrentPage(),
        '/home': (context) => HomePage(),
        '/payment': (context) => PaymentPage(),
      },
    );
  }
}
