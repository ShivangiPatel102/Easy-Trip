import 'package:flutter/material.dart';

class ButtonUpdateGuests extends StatelessWidget {
  const ButtonUpdateGuests(
      {super.key, @required this.widget, @required this.colour});

  final Color? colour;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 45,
      // width: 45,
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: widget,
    );
  }
}
