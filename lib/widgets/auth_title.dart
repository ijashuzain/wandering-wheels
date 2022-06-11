import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthTitle({
    Key? key,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: SizedBox(
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.w,
              width: 20.w,
              child: Image.asset("assets/icons/ww-logo.png"),
            ),
            SizedBox(
              width: 2.w,
            ),
            SizedBox(
              height: 9.h,
              width: 60.w,
              child: Stack(
                children: [
                  Positioned(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.h,
                    child: Text(
                      subtitle,
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
            )
          ],
        ),
      ),
    );
  }
}
