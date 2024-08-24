import 'package:flutter/material.dart';
import 'package:social_logins/constants.dart';

class ButtonOfNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final IconData icon;
  final void Function(int) onTap;

  const ButtonOfNavigationBar({
    super.key,
    required this.index,
    required this.icon,
    required this.onTap,
    required this.selectedIndex
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: selectedIndex == index ? kDarkGreyColor : kVeryLightGreyColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: selectedIndex == index ? Colors.white : kDarkGreyColor,
        ),
        onPressed: () => onTap(index),
        // Adjust colors
      ),
    );
  }
}

