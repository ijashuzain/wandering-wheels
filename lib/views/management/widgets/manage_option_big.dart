import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class ManageOptionBig extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const ManageOptionBig({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 100.w,
        height: 25.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            color: kPrimaryColor,
            width: 0.2.w,
          ),
        ),
        child: Center(
          child: ListTile(
            leading: Icon(
              icon,
              color: kPrimaryColor,
              size: 12.w,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontFamily: "Poppins",
              ),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w500,
                color: kSecondaryColor,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
