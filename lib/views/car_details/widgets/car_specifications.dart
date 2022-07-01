import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/views/car_details/car_pickupmap.dart';
import 'package:wandering_wheels/widgets/underlined_titile.dart';

class CarSpecifications extends StatelessWidget {
  final String year;
  final String manufacturer;
  final String model;
  final int qty;
  final String mileage;
  final String seats;
  final String fuel;
  final String regNumber;
  final double lat;
  final double lng;
  const CarSpecifications({
    Key? key,
    required this.year,
    required this.manufacturer,
    required this.model,
    required this.mileage,
    required this.seats,
    required this.fuel,
    required this.regNumber,
    required this.qty,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UnderlinedHeading("Vehicle Specifications"),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpecWidget(
              title: "Year",
              content: year,
              isFirst: true,
            ),
            SpecWidget(
              title: "Manufacturer",
              content: manufacturer,
            ),
            SpecWidget(
              title: "Model",
              isLast: true,
              content: model,
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpecWidget(
              isFirst: true,
              title: "Mileage",
              content: mileage,
            ),
            SpecWidget(
              title: "Seats",
              content: seats,
            ),
            SpecWidget(
              title: "Fuel",
              isLast: true,
              content: fuel,
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpecWidget(
              isFirst: true,
              title: "Reg. Number",
              content: regNumber,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pickup Location",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: kSecondaryColor,
                    fontFamily: "Poppins",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarPickupMap(
                          lat: lat,
                          lng: lng,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    child: Icon(
                      Icons.map,
                      size: 14.sp,
                      color: kLiteColor,
                    ),
                  ),
                )
              ],
            ),
            SpecWidget(
              isLast: true,
              title: "Total Cars",
              content: qty.toString(),
            ),
          ],
        ),
      ],
    );
  }
}

class SpecWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool isLast;
  final bool isFirst;
  const SpecWidget({
    Key? key,
    required this.title,
    required this.content,
    this.isLast = false,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w / 3,
      child: Column(
        crossAxisAlignment: isFirst
            ? CrossAxisAlignment.start
            : isLast
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: kSecondaryColor,
              fontFamily: "Poppins",
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );
  }
}
