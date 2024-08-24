import 'package:flutter/material.dart';
import 'package:social_logins/constants.dart';
import 'package:social_logins/widgets/button_of_navigationbar.dart';

class BottomNavbarCustom extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const BottomNavbarCustom({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
      margin: EdgeInsets.fromLTRB(30, 0, 30, 28),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: kVeryLightGreyColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),

      // height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ButtonOfNavigationBar(
              index: 0, // Pass index for each button
              icon: Icons.search_outlined,
              onTap: onItemTapped,
              selectedIndex: selectedIndex,
            ),
          ),
          Expanded(
            child: ButtonOfNavigationBar(
              index: 1, // Pass index for each button
              icon: Icons.notifications_outlined,
              onTap: onItemTapped,
              selectedIndex: selectedIndex,
            ),
          ),
          Expanded(
            child: ButtonOfNavigationBar(
              index: 2, // Pass index for each button
              icon: Icons.favorite_border_outlined,
              onTap: onItemTapped,
              selectedIndex: selectedIndex,
            ),
          ),
          Expanded(
            child: ButtonOfNavigationBar(
              index: 3, // Pass index for each button
              icon: Icons.calendar_month,
              onTap: onItemTapped,
              selectedIndex: selectedIndex,
            ),
          ),
          
        ],
      ),
    );
  }
}
