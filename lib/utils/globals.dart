import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class Globals {
  static showCustomDialog(
      {required BuildContext context,
      required String title,
      required String content}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            fontFamily: "Poppins",
            color: kPrimaryColor,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10.sp,
            fontFamily: "Poppins",
            color: kSecondaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          )
        ],
      ),
    );
  }

  findDueDays(String returnDate) {}
}
