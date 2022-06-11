import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';

class UnderlinedHeading extends StatelessWidget {
  final String title;
  const UnderlinedHeading(this.title,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              fontFamily: "Poppins",
            ),
          ),
          const Divider(
            color: kSecondaryColor,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
