import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';

class RentalCard extends StatelessWidget {
  final String driverName;
  final String carName;
  final String pickupDate;
  final String returnDate;
  final String status;
  final VoidCallback onTap;

  const RentalCard({
    Key? key,
    required this.driverName,
    required this.carName,
    required this.pickupDate,
    required this.returnDate,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 30.w,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
              color: kPrimaryColor,
              width: 0.3.w,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      driverName,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        border: Border.all(
                          color: kPrimaryColor,
                          width: 0.3.w,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            color: kLiteColor,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  carName,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: kSecondaryColor,
                    fontFamily: "Poppins",
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    SizedBox(
                      width: 25.w,
                      child: Text(
                        pickupDate,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
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
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
