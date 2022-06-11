import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CarTitle extends StatelessWidget {
  final String title;
  final String category;

  const CarTitle({
    Key? key,
    required this.title,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
            fontFamily: "Poppins",
          ),
        ),
        Text(
          category,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: kSecondaryColor,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }
}
