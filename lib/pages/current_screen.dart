import 'package:flutter/material.dart';
import 'package:social_logins/pages/home_page.dart';
import 'package:social_logins/widgets/bottom_navbar_custom.dart';

class CurrentPage extends StatefulWidget {
  const CurrentPage({super.key});

  @override
  State<CurrentPage> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> widgetListForBottomNav = [
    HomePage(),
    Scaffold(
      body: Container(
        child: Center(child: Text('Notifications')),
      ),
    ),
    Scaffold(
      body: Container(
        child: Center(child: Text('Favorites')),
      ),
    ),
    Scaffold(
      body: Container(
        child: Center(child: Text('Bookings')),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: widgetListForBottomNav,
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavbarCustom(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
