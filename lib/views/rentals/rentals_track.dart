import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';

class RentalsTrack extends StatelessWidget {
  static String routeName = "/rentals_track";
  const RentalsTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: ListTile(
          title: Text(
            "Track",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              fontSize: 12.sp,
            ),
          ),
          subtitle: Text(
            "Driver Name, Toyota Avalon 2020",
            style: TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              fontSize: 10.sp,
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child:  Center(
          child: Text(
            "This feature is under development",
            style: TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              fontSize: 10.sp,
            ),
          ),
        ),
      ),
    );
  }
}
