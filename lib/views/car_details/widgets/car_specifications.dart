import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/widgets/underlined_titile.dart';

class CarSpecifications extends StatelessWidget {
  final String year;
  final String manufacturer;
  final String model;
  final String mileage;
  final String seats;
  final String fuel;
  const CarSpecifications({
    Key? key,
    required this.year,
    required this.manufacturer,
    required this.model,
    required this.mileage,
    required this.seats,
    required this.fuel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        )
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
