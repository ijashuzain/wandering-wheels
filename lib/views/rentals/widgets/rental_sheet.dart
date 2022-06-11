import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/widgets/button.dart';

class RentalDetailSheet extends StatelessWidget {
  final String driverName;
  final String carName;
  final String driverPhone;
  final String driverEmail;
  final VoidCallback onTrack;
  final String pickupDate;
  final String returnDate;
  final String driverPlace;

  const RentalDetailSheet(
      {Key? key,
      required this.driverName,
      required this.carName,
      required this.driverPhone,
      required this.driverEmail,
      required this.onTrack,
      required this.pickupDate,
      required this.returnDate,
      required this.driverPlace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 100.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              driverName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontFamily: "Poppins",
              ),
            ),
            Text(
              carName,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: kSecondaryColor,
                fontFamily: "Poppins",
              ),
            ),
            Divider(
              height: 4.h,
            ),
            Row(
              children: [
                RentalSheetData(
                  title: "Phone",
                  value: driverPhone,
                ),
                const Spacer(),
                RentalSheetData(
                  title: "Email",
                  value: driverEmail,
                  isRight: true,
                ),
              ],
            ),
            SizedBox(height: 4.h),
            RentalSheetData(
              title: "Place",
              value: driverPlace,
            ),
            SizedBox(height: 4.h),
            Text(
              "Rental Date",
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontFamily: "Poppins",
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 25.w,
                  child: Text(
                    pickupDate,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: kSecondaryColor,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward),
                SizedBox(
                  width: 25.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      returnDate,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryColor,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: 100.w,
              child: CButton(
                title: "Track",
                onTap: () {
                  onTrack();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RentalSheetData extends StatelessWidget {
  final String title;
  final String value;
  final bool isRight;
  const RentalSheetData({
    Key? key,
    required this.title,
    required this.value,
    this.isRight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
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
          value,
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
