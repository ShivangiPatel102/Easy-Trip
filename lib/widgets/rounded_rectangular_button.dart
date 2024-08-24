import 'package:flutter/material.dart';
import 'package:social_logins/constants.dart';

class RoundedRectangularButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const RoundedRectangularButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kDarkGreyColor.withOpacity(0.3),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1D2725), // Set the button color
          foregroundColor: Color(0xFFF4F5F7), // Set the text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          child: Text(
            label,
            style: TextStyle(
              color: kWhiteBgColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
