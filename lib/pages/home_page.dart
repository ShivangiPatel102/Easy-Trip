import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_logins/constants.dart';
import 'package:social_logins/pages/details_page.dart';
import 'package:social_logins/providers/booking_data.dart';
import 'package:social_logins/providers/user_data.dart';
import 'package:social_logins/services/cloud_function_networking.dart';
import 'package:social_logins/services/log_events.dart';
import 'package:social_logins/services/update_profile_photo.dart';
import 'package:social_logins/widgets/card_popular_hotels.dart';
import 'package:social_logins/widgets/my_ad_widget.dart';
import 'package:social_logins/widgets/my_top_button.dart';
import 'package:social_logins/widgets/profile_image_widget.dart';
import 'package:social_logins/widgets/themed_status_bar.dart';

final PageController _controller = PageController(viewportFraction: 1);

enum Category {
  All,
  Hotels,
  Apartments,
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // File? profileimage;
  final ImagePicker picker = ImagePicker();
  // String imageUrl = '';

  //we can upload from gallery and camera
  // Future getImage(ImageSource media) async {
  //   var img = await picker.pickImage(source: media);
  //   File? profileimage = File(img!.path);
  //   await UpdateProfilePhoto.setProfilePhoto(profileimage!, context, ref);
  //   setState(() {
  //     // re run build func
  //   });
  // }

  // variables
  Category selectedCategory = Category.All;
  bool gotData = false;
  List<dynamic> bookingData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> setBookingDataInProvider() async {
    Map<String, dynamic> result = await fetchBookingData();
    List<dynamic> resultList = await result['result'];

    try {
      // Use ref.read to access the provider
      ref.read(bookingDataProvider).setBookingData(resultList);
      // print('data set in provider');
    } catch (e) {
      // print('Error in setting data in provider $e');
      throw e;
    }
  }

  Future<void> getData() async {
    await setBookingDataInProvider();
    // Update the local state after setting data
    setState(() {
      gotData = true;
      bookingData = ref.watch(bookingDataProvider.notifier).bookingData;
    });
    // print(bookingData);
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);

    return SafeArea(
      child: ThemedStatusBar(
        child: Scaffold(
          body: bookingData.isNotEmpty
              ? Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    // Top Bar -saying find the best for your holiday
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        title: Text(
                          "Find the best\nfor your holiday",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const ProfileImageWidget(
                            // context: context,
                            ),
                      ),
                    ),
                    // Other
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          // Top Row Padded - Scrolling Categories
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyTopButton(
                                    title: 'All',
                                    count: 123,
                                    buttonColor:
                                        selectedCategory == Category.All
                                            ? kDarkGreyColor
                                            : kWhiteColor,
                                    textColor: selectedCategory == Category.All
                                        ? kWhiteColor
                                        : kDarkGreyColor,
                                    onPress: () {
                                      setState(() {
                                        selectedCategory = Category.All;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10.0),
                                  MyTopButton(
                                    title: 'Hotels',
                                    count: 24,
                                    buttonColor:
                                        selectedCategory == Category.Hotels
                                            ? kDarkGreyColor
                                            : kWhiteColor,
                                    textColor:
                                        selectedCategory == Category.Hotels
                                            ? kWhiteColor
                                            : kDarkGreyColor,
                                    onPress: () {
                                      setState(() {
                                        selectedCategory = Category.Hotels;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10.0),
                                  MyTopButton(
                                    title: 'Apartments',
                                    count: 12,
                                    buttonColor:
                                        selectedCategory == Category.Apartments
                                            ? kDarkGreyColor
                                            : kWhiteColor,
                                    textColor:
                                        selectedCategory == Category.Apartments
                                            ? kWhiteColor
                                            : kDarkGreyColor,
                                    onPress: () {
                                      setState(() {
                                        selectedCategory = Category.Apartments;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
              
                          // Popular Hotel heading
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Popular Hotels',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                const Text(
                                  'See all',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
              
                          const SizedBox(
                            height: 20,
                          ),
              
                          // Scrollable Popular Hotels Cards
                          Expanded(
                            flex: 25,
                            child: PageView.builder(
                              controller: _controller,
              
                              itemCount: 5, // Number of cards
                              itemBuilder: (BuildContext context, int index) {
                                var itemData = bookingData[index];
                                String name = itemData['name'];
                                String location = itemData['address'];
              
                                return GestureDetector(
                                  onTap: () {
                                    logHotelClickEvent(name);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            DetailsPage(indexOfItem: index)),
                                      ),
                                    );
                                    
                                  },
                                  child: CardPopularHotels(
                                    name: name,
                                    location: location,
                                  ),
                                );
                              },
                            ),
                          ),
                          //  Smooth page indicator
                          Expanded(
                            flex: 1,
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
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            flex: 4,
                            child: MyAdWidget(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
