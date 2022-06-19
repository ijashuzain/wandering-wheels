import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/booking_provider.dart';
import 'package:wandering_wheels/views/booking/booking_track.dart';
import 'package:wandering_wheels/views/booking/widgets/booking_card.dart';
import 'package:wandering_wheels/views/booking/widgets/booking_sheet.dart';

class BookingAll extends StatefulWidget {
  static String routeName = '/rentals';
  const BookingAll({Key? key}) : super(key: key);

  @override
  State<BookingAll> createState() => _BookingAllState();
}

class _BookingAllState extends State<BookingAll> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      context.read<CarBookingProvider>().fetchAllBookings(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text(
          "Bookings",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Consumer<CarBookingProvider>(
          builder: (context, provider, child) {
            if (provider.isAllBookingLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if (provider.allBookings.isEmpty) {
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
                      itemCount: provider.allBookings.length,
                      itemBuilder: (context, index) {
                        return BookingCard(
                          driverName: provider.allBookings[index].driverName,
                          carName: provider.allBookings[index].car!.name,
                          pickupDate: provider.allBookings[index].pickupDate,
                          returnDate: provider.allBookings[index].returnDate,
                          status: provider.allBookings[index].status,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              builder: (context) => BookingDetailSheet(
                                isManage: true,
                                isLoading: provider.bookingUpdating,
                                driverName:
                                    provider.allBookings[index].driverName,
                                carName: provider.allBookings[index].car!.name,
                                driverEmail:
                                    provider.allBookings[index].driverEmail,
                                driverPhone:
                                    provider.allBookings[index].driverPhone,
                                driverPlace:
                                    provider.allBookings[index].driverPlace,
                                pickupDate:
                                    provider.allBookings[index].pickupDate,
                                returnDate:
                                    provider.allBookings[index].returnDate,
                                status: provider.allBookings[index].status,
                                returnedDate:
                                    provider.allBookings[index].returnedDate!,
                                onTrack: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookingTrack(bookingData: provider.allBookings[index])));
                                },
                                onStatusUpdate: (val) {
                                  context
                                      .read<CarBookingProvider>()
                                      .updateBookingStatus(
                                        status: val,
                                        id: provider
                                            .allBookings[index].bookingId,
                                      );
                                  Navigator.pop(
                                      _scaffoldKey.currentState!.context);
                                  context
                                      .read<CarBookingProvider>()
                                      .fetchAllBookings(
                                          _scaffoldKey.currentState!.context);
                                },
                                onDelete: () {
                                  context
                                      .read<CarBookingProvider>()
                                      .deleteBooking(
                                        id: provider
                                            .allBookings[index].bookingId,
                                      );
                                  Navigator.pop(
                                      _scaffoldKey.currentState!.context);
                                  context
                                      .read<CarBookingProvider>()
                                      .fetchAllBookings(
                                          _scaffoldKey.currentState!.context);
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
