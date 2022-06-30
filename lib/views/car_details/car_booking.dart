import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/models/booking_model.dart';
import 'package:wandering_wheels/models/car_model.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/booking_provider.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/insurance_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/widgets/button.dart';
import 'package:wandering_wheels/widgets/date_picker.dart';
import 'package:wandering_wheels/widgets/text_field.dart';
import 'package:wandering_wheels/widgets/underlined_titile.dart';

class CarBooking extends StatefulWidget {
  static String routeName = "/car_booking";

  CarBooking({Key? key}) : super(key: key);

  @override
  State<CarBooking> createState() => _CarBookingState();
}

class _CarBookingState extends State<CarBooking> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  String pickupDate = "";
  String returnDate = "";

  @override
  void initState() {
    pickupDate = "";
    returnDate = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: Consumer<CarProvider>(builder: (context, provider, child) {
          return ListTile(
            title: Text(provider.currentCar!.name),
            subtitle: const Text("Book your car"),
          );
        }),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    children: [
                      const UnderlinedHeading("Rental Date"),
                      SizedBox(height: 2.h),
                      CDatePicker(
                        firstDate: DateTime.now(),
                        onSelected: (val) {
                          setState(() {
                            pickupDate = val;
                            returnDate = '';
                          });
                        },
                        title: "Pickup Date",
                        value: pickupDate,
                      ),
                      SizedBox(height: 2.h),
                      CDatePicker(
                        firstDate: pickupDate == ''
                            ? DateTime.now()
                            : DateTime.parse(pickupDate),
                        onSelected: (val) {
                          setState(() {
                            returnDate = val;
                          });
                        },
                        title: "Return Date",
                        value: returnDate,
                      ),
                      SizedBox(height: 6.h),
                      const UnderlinedHeading("Driver Details"),
                      CTextField(controller: nameController, hint: "Name"),
                      CTextField(controller: phoneController, hint: "Phone"),
                      CTextField(controller: emailController, hint: "Email"),
                      CTextField(controller: placeController, hint: "Place"),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Consumer<BookingProvider>(
                  builder: (context, provider, child) {
                    Car car = context.read<CarProvider>().currentCar!;
                    UserData? user = context.read<UserProvider>().currentUser;
                    String insuranceType =
                        context.read<InsuranceProvider>().selectedInsuranceType;
                    String amount = insuranceType == "NONE"
                        ? car.rate.toString()
                        : insuranceType == "BASIC"
                            ? (car.rate + 500).toString()
                            : (car.rate + 1000).toString();
                    int dateDefference = 1;
                    if (pickupDate.isNotEmpty && returnDate.isNotEmpty) {
                      if (pickupDate == returnDate) {
                        dateDefference = 1;
                      } else {
                        var date1 = DateTime.parse(pickupDate);
                        var date2 = DateTime.parse(returnDate);
                        dateDefference = date2.difference(date1).inDays;
                      }
                    }
                    var payableAmount = int.parse(amount) * dateDefference;
                    log(dateDefference.toString());
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Payable Amount : $payableAmount",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: kSecondaryColor),
                        ),
                        SizedBox(height: 1.h),
                        CButton(
                          isDisabled: provider.isAddingBooking,
                          isLoading: provider.isAddingBooking,
                          title: "Book Now",
                          onTap: () {
                            Booking booking = Booking(
                              car: null,
                              rate: payableAmount.toString(),
                              driverName: nameController.text,
                              driverEmail: emailController.text,
                              driverPhone: phoneController.text,
                              driverPlace: placeController.text,
                              carId: car.id!,
                              returnedDate: null,
                              userId: user!.id!,
                              bookingId: '',
                              insuranceType: insuranceType,
                              pickupDate: pickupDate,
                              returnDate: returnDate,
                              status: '',
                            );

                            //validate
                            if (nameController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                placeController.text.isEmpty ||
                                pickupDate.isEmpty ||
                                returnDate.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "Oops",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: kPrimaryColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  content: Text(
                                    "Please fill all fields",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: kSecondaryColor,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                              return;
                            } else {
                              context.read<BookingProvider>().addBooking(
                                    booking: booking,
                                    onSuccess: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            "Completed",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kPrimaryColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          content: Text(
                                            "Car booking has successfully completed. Please wait for confirmation.",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kSecondaryColor,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onError: (error) {
                                      //clear fields
                                      nameController.clear();
                                      phoneController.clear();
                                      emailController.clear();
                                      placeController.clear();
                                      pickupDate = "";
                                      returnDate = "";

                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Error"),
                                          content: Text(error),
                                          actions: [
                                            FlatButton(
                                              child: const Text("OK"),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
