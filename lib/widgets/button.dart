import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';

class CButton extends StatelessWidget {
  final bool isLoading;
  final String title;
  final bool isDisabled;
  final VoidCallback onTap;
  final bool expand;
  const CButton({
    Key? key,
    this.isLoading = false,
    required this.title,
    this.isDisabled = false,
    required this.onTap, this.expand = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          onTap();
        }
      },
      child: Container(
        width: expand ? 100.w : 35.w,
        height: 5.5.h,
        decoration: BoxDecoration(
          color: isDisabled ? kSecondaryColor : kPrimaryColor,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Center(
          child: isLoading
              ? const CupertinoActivityIndicator(
                  color: kLiteColor,
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: kLiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
        ),
      ),
    );
  }
}
