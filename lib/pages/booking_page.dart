import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_logins/constants.dart';
import 'package:social_logins/providers/booking_data.dart';
import 'package:social_logins/services/payment.dart';
import 'package:social_logins/widgets/booking_button_with_price.dart';
import 'package:social_logins/widgets/button_choose_options.dart';
import 'package:social_logins/widgets/button_update_guests.dart';

enum Operation { minus, add }

enum Options { nothing, breakfast, late_check_in }

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({super.key, required this.indexOfItem});
  final int indexOfItem;

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  List<DateTime?> selectedDate = [DateTime.now()];
  List<DateTime?> selectedRounds = [];
  int guests = 1;
  Operation selectedButton = Operation.add;
  Options selectedOption = Options.nothing;
 

  
  @override
  Widget build(BuildContext context) {
    List<dynamic> bookingData =
        ref.watch(bookingDataProvider.notifier).bookingData;
    var itemData = bookingData[widget.indexOfItem];

    String name = itemData['name'];
    String address = itemData['address'];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95,
        backgroundColor: kDarkGreyColor,
        centerTitle: true,
        title: Text(
          name ?? 'Siargao Luxury Resort',
          style: TextStyle(
            color: kWhiteColor,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              address ?? 'Siargao Island, Phillipines',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: kLightGreyColor,
              ),
            ),
          ),
        ),
      ),
      // extendBody:  true,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: kDarkGreyColor,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    color: kWhiteBgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Date Picker
                      Center(
                        child: Container(
                          // width: 300,
                          // height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: CalendarDatePicker2(
                              config: CalendarDatePicker2Config(
                                calendarType: CalendarDatePicker2Type.single,
                                selectedDayHighlightColor: kDarkGreyColor,
                                dayTextStyle: const TextStyle(
                                  color: kDarkGreyColor,
                                ),
                                firstDate: DateTime.now(),
                                weekdayLabels: [
                                  'Sun',
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thur',
                                  'Fri',
                                  'Sat'
                                ],
                                weekdayLabelTextStyle: const TextStyle(
                                  color: kDarkGreyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                // Example
                              ),
                              value: selectedDate,
                              onValueChanged: (newDate) {
                                setState(() {
                                  selectedDate = newDate;

                                  if (selectedRounds.contains(newDate)) {
                                    selectedRounds.remove(newDate);
                                  } else {
                                    // selectedRounds.add(newDate);
                                  }
                                });
                              }),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // Number of Guests
                      Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: const BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Guests',
                              style: kTextStyleHeadingDetailsPage,
                            ),
                            const Spacer(),
                            Container(
                              child: Row(
                                children: [
                                  ButtonUpdateGuests(
                                    colour: kLightGreyColor,
                                    widget: IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        color: kDarkGreyColor,
                                      ),
                                      onPressed: () {
                                        if (guests > 0) {
                                          setState(() {
                                            // selectedButton = Operation.minus;
                                            guests = guests - 1;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$guests',
                                          style: kTextStyleHeadingDetailsPage,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ButtonUpdateGuests(
                                    colour: kDarkGreyColor,
                                    widget: IconButton(
                                      icon: Icon(
                                        color: kWhiteColor,
                                        Icons.add,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          selectedButton = Operation.add;
                                          guests = guests + 1;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // flex:  3,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOption = Options.breakfast;
                                });
                              },
                              child: ButtonChooseOptions(
                                title: 'Breakfast',
                                price: '15.00',
                                colour: selectedOption == Options.breakfast
                                    ? kDarkGreyColor
                                    : kWhiteColor,
                                textColor: selectedOption == Options.breakfast
                                    ? kWhiteColor
                                    : kLightGreyColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          // Spacer(),
                          Expanded(
                            // flex: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOption = Options.late_check_in;
                                });
                              },
                              child: ButtonChooseOptions(
                                title: 'Late check-in',
                                price: '10.00',
                                colour: selectedOption == Options.late_check_in
                                    ? kDarkGreyColor
                                    : kWhiteColor,
                                textColor:
                                    selectedOption == Options.late_check_in
                                        ? kWhiteColor
                                        : kLightGreyColor,
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 100,)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: BookingButtonWithPrice(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
