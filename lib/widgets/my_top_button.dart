import 'package:flutter/material.dart';
import 'package:social_logins/constants.dart';


class MyTopButton extends StatelessWidget {
  MyTopButton({
    super.key,
    required this.title,
    required this.count,
    required this.buttonColor,
    @required this.onPress,
    @required this.textColor,
  });
  final String title;
  final int count;
  final Color? buttonColor;
  final VoidCallback? onPress;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPress,
        child: Row(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontSize: 17,
                color: textColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 12,
                color: textColor,
              ),
            ),
          ],
        ),
        style: FilledButton.styleFrom(
          backgroundColor: buttonColor,
          // backgroundColor: kDarkGreyColor,
          // foregroundColor: Colors.white,
          // disabledBackgroundColor: kWhiteColor,
          // disabledForegroundColor: kDarkGreyColor,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
        ));
  }
}
