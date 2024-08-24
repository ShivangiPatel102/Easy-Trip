import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_logins/constants.dart';
import 'package:social_logins/pages/booking_page.dart';
import 'package:social_logins/providers/booking_data.dart';
import 'package:social_logins/services/log_events.dart';
import 'package:social_logins/widgets/container_displaying_amenitites.dart';
import 'package:social_logins/widgets/container_image_of_about.dart';
import 'package:social_logins/widgets/rounded_rectangular_button.dart';

final PageController _controller = PageController(viewportFraction: 1);

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key, required this.indexOfItem});
  final int indexOfItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // variables
    List<dynamic> bookingData =
        ref.watch(bookingDataProvider.notifier).bookingData;



    return Scaffold(
 
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            // Other Body
            BodyOfDetailsPage(
              indexOfItem: indexOfItem,
            ),
            // Like Button
            Positioned(
              top: 20,
              right: 8,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () => {},
                ),
              ),
            ),
            // Back Button
            Positioned(
              top: 20,
              left: 8,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: IconButton(
                  iconSize: 30,
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: kLightGreyColor,
                  ),
                  onPressed: () => {Navigator.pop(context)},
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          height: 90,
                          color: kWhiteColor.withOpacity(0.5),
                          child: RoundedRectangularButton(
                            label: 'Book',
                            onPressed: () {
                              logBookButtonClickEvent(
                                  bookingData[indexOfItem]['name']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingPage(
                                    indexOfItem: indexOfItem,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class BodyOfDetailsPage extends ConsumerWidget {
  const BodyOfDetailsPage({super.key, required this.indexOfItem});
  final int indexOfItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<dynamic> bookingData =
        ref.watch(bookingDataProvider.notifier).bookingData;
    var itemData = bookingData[indexOfItem];
    String price = itemData['price_per_night'] ?? '';
    String name = itemData['name'];
    String address = itemData['address'];
    List amenities = itemData['amenities'];

    return ListView(
      padding: EdgeInsets.zero,
      children: [

      
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35.0), // Adjust the radius as needed
              bottomRight: Radius.circular(35.0),
            ),
  
          ),
          child: Stack(
            children: [
              Container(height: 50, width: 50, color: Colors.red,),
              PageView.builder(
                controller: _controller,
                itemCount: 5, // Number of cards
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/details');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            35.0), // Adjust the radius as needed
                        bottomRight: Radius.circular(35.0),
                      ),
                      child: Image.network(
                        'https://www.journeyera.com/wp-content/uploads/2022/01/resorts-in-siargao-242829150.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  );
                },
              ),
              // Image of Resort

              // Price tag
              Positioned(
                top: 240,
                right: 0,
                bottom: 30,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kDarkGreyColor.withOpacity(0.7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          price.isNotEmpty
                              ? Text(
                                  '🔥$price/  ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              : Text(
                                  '🔥INR 2000/  ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                          Text(
                            'night',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Scroller
              Container(
                alignment: Alignment.center,
                height: 20,
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 5,
                  effect: const WormEffect(
                    dotHeight: 5,
                    dotWidth: 5,
                    type: WormType.thin,
                    strokeWidth: 5,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.black,
                  ),
                ),
              ),
              // Heading or title
              Container(
                // height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        name ?? '',
                        style: const TextStyle(
                            fontSize: 25,
                            color: kDarkGreyColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.location_on_sharp,
                        color: kLightGreyColor,
                      ),
                      title: Text(
                        address ?? '',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      trailing: Text(
                        '4.5 ⭐',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kDarkGreyColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: kLightGreyColor,
                    ),
                  ],
                ),
              ),
              // Amenities
              Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Amenities',
                        style: kTextStyleHeadingDetailsPage,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    // Scrolling Row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: amenities.map((amenity) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ContainerDisplayingAmenities(
                              title: amenity,
                              iconData: Icons.adjust,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              // About
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: kTextStyleHeadingDetailsPage,
                    ),
                    Text(
                      'This is a perfect place to stay when you are at Siargao. Comes with Parking lot & every driver tricycle driver knows this place.',
                      style: TextStyle(
                        color: kLightGreyColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Images
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ContainerImageOfAbout(
                      imageText: image1,
                    ),
                    SizedBox(width: 10.0),
                    ContainerImageOfAbout(
                      imageText: image1,
                    ),
                    SizedBox(width: 10.0),
                    ContainerImageOfAbout(
                      imageText: image1,
                    ),
                    SizedBox(width: 10.0),
                    ContainerImageOfAbout(
                      imageText: image1,
                    ),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
              // Gap
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ],
    );
  }
}



