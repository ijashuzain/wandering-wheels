import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/booking_provider.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';
import 'package:wandering_wheels/views/home/widgets/car_card.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({Key? key}) : super(key: key);

  void fetchMyBookings(BuildContext context) {
    context.read<CarBookingProvider>().fetchMyBookings();
  }

  @override
  Widget build(BuildContext context) {
    fetchMyBookings(context);
    return Scaffold(
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
              ),
            ),
            Expanded(
              child: Consumer<CarBookingProvider>(
                  builder: (context, provider, child) {
                if (provider.isLoading) {
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
                  padding: EdgeInsets.only(right: 3.h),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 3.h,
                    ),
                    itemCount: provider.myBookings.length,
                    itemBuilder: (context, index) {
                      return CarCard(
                        carName: provider.myBookings[index].name,
                        carImage: provider.myBookings[index].image!,
                        carRate: provider.myBookings[index].rate.toString(),
                        onTap: () {
                          context
                              .read<CarProvider>()
                              .setCurrentCar(provider.myBookings[index]);
                          Navigator.pushNamed(context, CarDetails.routeName);
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
