import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/constants/status.dart';
import 'package:wandering_wheels/widgets/button.dart';

class BookingDetailSheet extends StatelessWidget {
  bool isManage;
  final String driverName;
  final String carName;
  final String carId;
  final String driverPhone;
  final String driverEmail;
  final VoidCallback onTrack;
  final String pickupDate;
  final String returnDate;
  final String driverPlace;
  final String returnedDate;
  final String status;
  final Function(String) onStatusUpdate;
  final bool isLoading;
  final VoidCallback onDelete;

  BookingDetailSheet({
    Key? key,
    this.isManage = false,
    required this.driverName,
    required this.carName,
    required this.driverPhone,
    required this.driverEmail,
    required this.onTrack,
    required this.pickupDate,
    required this.returnDate,
    required this.driverPlace,
    required this.status,
    required this.onStatusUpdate,
    this.isLoading = false,
    required this.onDelete,
    required this.returnedDate,
    required this.carId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
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
            SizedBox(height: 3.h),
            RentalSheetData(
              title: "Place",
              value: driverPlace,
            ),
            SizedBox(height: 3.h),
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
                const Icon(Icons.arrow_forward),
                SizedBox(width: 3.w),
                SizedBox(
                  width: 25.w,
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
              ],
            ),
            SizedBox(height: 4.h),
            RentalSheetData(
              title: "Retuned Date",
              value: returnedDate == '' ? "Not yet returned" : returnedDate,
            ),
            SizedBox(height: 2.h),
            Center(
              child: carId == "1"
                  ? CButton(
                      title: "Delete",
                      isDisabled: isLoading,
                      isLoading: isLoading,
                      onTap: () {
                        onDelete();
                      },
                    )
                  : interactionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget interactionButton() {
    if (isManage) {
      //
      if (status == BookingStatus.pending) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CButton(
              isDisabled: isLoading,
              isLoading: isLoading,
              title: "Approve",
              onTap: () {
                onStatusUpdate(BookingStatus.onroad);
              },
            ),
            SizedBox(
              width: 1.h,
            ),
            CButton(
              isDisabled: isLoading,
              isLoading: isLoading,
              title: "Reject",
              onTap: () {
                onStatusUpdate(BookingStatus.rejected);
              },
            )
          ],
        );
      } else if (status == BookingStatus.rejected &&
          status == BookingStatus.completed) {
        return CButton(
          isDisabled: isLoading,
          isLoading: isLoading,
          title: "Delete",
          onTap: () {
            onDelete();
          },
        );
      } else if (status == BookingStatus.onroad ||
          status == BookingStatus.overdue) {
        return CButton(
          title: "Track",
          onTap: () {
            onTrack();
          },
        );
      } else if (status == BookingStatus.returnRequest) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CButton(
              isDisabled: isLoading,
              isLoading: isLoading,
              title: "Return Accept",
              onTap: () {
                onStatusUpdate(BookingStatus.completed);
              },
            ),
            SizedBox(
              width: 1.h,
            ),
            CButton(
              isDisabled: isLoading,
              isLoading: isLoading,
              title: "Return Reject",
              onTap: () {
                onStatusUpdate(BookingStatus.onroad);
              },
            )
          ],
        );
      } else if (status == BookingStatus.rejected ||
          status == BookingStatus.completed) {
        return CButton(
          isDisabled: isLoading,
          isLoading: isLoading,
          title: "Delete",
          onTap: () {
            onDelete();
          },
        );
      } else {
        return const SizedBox();
      }
    } else {
      if (status == BookingStatus.pending) {
        return CButton(
          isDisabled: isLoading,
          isLoading: isLoading,
          title: "Cancel",
          onTap: () {
            onDelete();
          },
        );
      } else if (status == BookingStatus.onroad ||
          status == BookingStatus.overdue) {
        return CButton(
          isDisabled: isLoading,
          isLoading: isLoading,
          title: "Return",
          onTap: () {
            onStatusUpdate(BookingStatus.returnRequest);
          },
        );
      } else if (status == BookingStatus.rejected) {
        return CButton(
          title: "Delete",
          isDisabled: isLoading,
          isLoading: isLoading,
          onTap: () {
            onDelete();
          },
        );
      } else if (status == BookingStatus.returnRequest) {
        return CButton(
          isDisabled: isLoading,
          isLoading: isLoading,
          title: "Cancel Return",
          onTap: () {
            onStatusUpdate(BookingStatus.onroad);
          },
        );
      } else {
        return const SizedBox();
      }
    }
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
