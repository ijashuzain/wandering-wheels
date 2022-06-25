import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/constants/status.dart';
import 'package:wandering_wheels/providers/booking_provider.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/views/booking/booking_track.dart';
import 'package:wandering_wheels/views/booking/widgets/booking_card.dart';
import 'package:wandering_wheels/views/booking/widgets/booking_sheet.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';
import 'package:wandering_wheels/views/home/widgets/car_card.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await context.read<BookingProvider>().fetchMyBookings(context);
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h, right: 3.h, left: 3.h),
              child: SizedBox(
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Bookings",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "Current Bookings",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: kSecondaryColor,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            context.read<BookingProvider>().fetchMyBookings(context);
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Consumer<BookingProvider>(
                builder: (context, provider, child) {
                  if (provider.isMyBookingLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }

                  if (provider.myBookings.isEmpty) {
                    return const Center(
                      child: Text("No Bookings found"),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: 3.h, left: 3.h),
                    child: ListView.builder(
                      itemCount: provider.myBookings.length,
                      itemBuilder: (context, index) {
                        num payableAmount = 0;
                        if(provider.myBookings[index].rate.isNotEmpty){
                          payableAmount = int.parse(provider.myBookings[index].rate);
                          if(provider.myBookings[index].status == BookingStatus.overdue){
                            var dueDifference = DateTime.now().difference(DateTime.parse(provider.myBookings[index].returnDate)).inDays;
                            payableAmount = payableAmount + (provider.myBookings[index].car!.rate * dueDifference);
                          }
                        }
                        return BookingCard(
                          driverName: provider.myBookings[index].driverName,
                          carName: provider.myBookings[index].car!.name,
                          pickupDate: provider.myBookings[index].pickupDate,
                          returnDate: provider.myBookings[index].returnDate,
                          status: provider.myBookings[index].status,
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: _scaffoldKey.currentState!.context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              builder: (context) => BookingDetailSheet(
                                rate: payableAmount.toString(),
                                isLoading: provider.bookingUpdating,
                                driverName: provider.myBookings[index].driverName,
                                carName: provider.myBookings[index].car!.name,
                                driverEmail: provider.myBookings[index].driverEmail,
                                driverPhone: provider.myBookings[index].driverPhone,
                                driverPlace: provider.myBookings[index].driverPlace,
                                pickupDate: provider.myBookings[index].pickupDate,
                                returnDate: provider.myBookings[index].returnDate,
                                status: provider.myBookings[index].status,
                                returnedDate: provider.myBookings[index].returnedDate!,
                                carId: provider.myBookings[index].car!.id!,
                                onTrack: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, BookingTrack.routeName);
                                },
                                onStatusUpdate: (val) async {
                                  log(val);
                                  await context.read<BookingProvider>().updateBookingStatus(
                                        status: val,
                                        id: provider.myBookings[index].bookingId,
                                      );
                                  Navigator.pop(_scaffoldKey.currentState!.context);
                                  await context.read<BookingProvider>().fetchMyBookings(_scaffoldKey.currentState!.context);
                                },
                                onDelete: () async {
                                  await context.read<BookingProvider>().deleteBooking(
                                        id: provider.myBookings[index].bookingId,
                                      );
                                  Navigator.pop(_scaffoldKey.currentState!.context);
                                  await context.read<BookingProvider>().fetchMyBookings(_scaffoldKey.currentState!.context);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
