import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:social_logins/constants.dart';
import 'package:social_logins/services/payment.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class BookingButtonWithPrice extends StatefulWidget {
  const BookingButtonWithPrice({
    super.key,
  });

  @override
  State<BookingButtonWithPrice> createState() => _BookingButtonWithPriceState();
}

class _BookingButtonWithPriceState extends State<BookingButtonWithPrice> {
  Future<void> _onButtonPressed() async{
     await Payment.initiatePayment();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kLightGreyColor.withOpacity(0.3),
          ),
          height: 100,
          child: Row(
            children: [
              const Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: kDarkGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '\$30.99',
                    style: TextStyle(
                      color: kDarkGreyColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Book Now Button
              TapDebouncer(
                onTap: () async {
                   await _onButtonPressed();
                },
              builder: (BuildContext context, TapDebouncerFunc? onTap) {
                return GestureDetector(
                onTap: onTap,
                child: Container(
                  // width: 80,
                  padding:
                      const EdgeInsets.symmetric(vertical: 19, horizontal: 65),
                  decoration: const BoxDecoration(
                    color: kDarkGreyColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Book now',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
              }),
            ],
          ),
        ),
      ),
    );
  }
}


