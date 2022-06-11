import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class Greeting extends StatelessWidget {
  final String name;
  const Greeting({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      width: 60.w,
      child: Stack(
        children: [
          Positioned(
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: kSecondaryColor,
                fontFamily: "Poppins",
              ),
            ),
          ),
          Positioned(
            top: 1.5.h,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
