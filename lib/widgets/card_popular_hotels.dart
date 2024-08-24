import 'dart:ui';

import 'package:flutter/material.dart';

class CardPopularHotels extends StatelessWidget {
  const CardPopularHotels({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3.0,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://www.journeyera.com/wp-content/uploads/2022/01/resorts-in-siargao-242829150.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: IconButton(
                iconSize: 30,
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Positioned(
            left: 5,
            bottom: 23,
            right: 5,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xFF1d2725).withOpacity(0.6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      '$name',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListTile(
                      textColor: Colors.white,
                      leading: const Icon(
                        Icons.location_on_sharp,
                        color: Colors.white,
                      ),
                      title: Text(
                        '$location',
                        style: TextStyle(fontSize: 8),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('4.9'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.star_rate_rounded,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
