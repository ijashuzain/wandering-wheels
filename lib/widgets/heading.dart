import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';

class Heading extends StatelessWidget {
  final String title;
  final String? subtitle;
  const Heading({ Key? key, required this.title, this.subtitle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      width: 100.w,
      child: Stack(
        children: [
          Positioned(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontFamily: "Poppins",
              ),
            ),
          ),
          Positioned(
            top: 2.5.h,
            child: Text(
              subtitle ?? "",
              style: TextStyle(
                fontSize: 9.sp,
                fontWeight: FontWeight.w500,
                color: kSecondaryColor,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ],
      ),
    );
  }
}