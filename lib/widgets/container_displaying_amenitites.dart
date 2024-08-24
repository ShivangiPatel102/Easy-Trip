import 'package:flutter/material.dart';
import 'package:social_logins/constants.dart';

class ContainerDisplayingAmenities extends StatelessWidget {
   ContainerDisplayingAmenities({
    super.key,
     this.iconData,
    required this.title,
  });
  final String title;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kLightGreyColor.withOpacity(0.4),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
          ),
          SizedBox(width: 10),
          Text('$title', style: TextStyle(fontSize: 15),),
        ],
      ),
    );
  }
}
