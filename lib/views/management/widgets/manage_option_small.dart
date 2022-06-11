import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class ManageOptionSmall extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const ManageOptionSmall({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            color: kPrimaryColor,
            width: 0.2.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: kPrimaryColor, size: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontFamily: "Poppins",
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w500,
                color: kSecondaryColor,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
