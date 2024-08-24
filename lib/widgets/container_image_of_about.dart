import 'package:flutter/material.dart';

class ContainerImageOfAbout extends StatelessWidget {
  ContainerImageOfAbout({
    super.key,
    required this.imageText,
  });
  final String imageText;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
      child: Container(
        height: 90,
        // width: 90,
        child: Image.network(
          imageText,
          // height: 90,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
