import 'package:flutter/material.dart';

class ButtonChooseOptions extends StatelessWidget {
  const ButtonChooseOptions(
      {super.key,
      required this.price,
      required this.title,
      @required this.colour,
      @required this.textColor});
  final String title;
  final String price;
  final Color? colour;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$title',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            '\$$price',
            style:  TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
