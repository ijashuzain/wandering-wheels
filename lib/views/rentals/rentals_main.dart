import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/rental_provider.dart';
import 'package:wandering_wheels/views/rentals/rentals_track.dart';
import 'package:wandering_wheels/views/rentals/widgets/rental_card.dart';
import 'package:wandering_wheels/views/rentals/widgets/rental_sheet.dart';

class RentalsMain extends StatelessWidget {
  static String routeName = '/rentals';
  const RentalsMain({Key? key}) : super(key: key);

  void fetchRentals(BuildContext context) {
    context.read<RentalProvider>().fetchRentals();
  }

  @override
  Widget build(BuildContext context) {
    fetchRentals(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const ListTile(
          title: Text(
            "Rentals",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Consumer<RentalProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if (provider.rentals.isEmpty) {
              return const Center(
                child: Text("No rentals found"),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  Padding(
                    padding: EdgeInsets.only(right: 3.h, left: 3.h),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.rentals.length,
                      itemBuilder: (context, index) {
                        return RentalCard(
                          driverName: provider.rentals[index].driverName,
                          carName: provider.rentals[index].carName,
                          pickupDate: provider.rentals[index].pickupDate,
                          returnDate: provider.rentals[index].returnDate,
                          status: provider.rentals[index].status,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              builder: (context) => RentalDetailSheet(
                                driverName: provider.rentals[index].driverName,
                                carName: provider.rentals[index].carName,
                                driverEmail:
                                    provider.rentals[index].driverEmail,
                                driverPhone:
                                    provider.rentals[index].driverPhone,
                                driverPlace:
                                    provider.rentals[index].driverPlace,
                                pickupDate: provider.rentals[index].pickupDate,
                                returnDate: provider.rentals[index].returnDate,
                                onTrack: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, RentalsTrack.routeName);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
