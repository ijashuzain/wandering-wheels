import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/views/car_details/car_booking.dart';
import 'package:wandering_wheels/views/car_details/widgets/car_specifications.dart';
import 'package:wandering_wheels/views/car_details/widgets/car_titile.dart';
import 'package:wandering_wheels/views/car_details/widgets/insurance_widget.dart';
import 'package:wandering_wheels/widgets/button.dart';
import 'package:wandering_wheels/widgets/underlined_titile.dart';

class CarDetails extends StatefulWidget {
  static String routeName = "/car_details";
  const CarDetails({Key? key}) : super(key: key);

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.h,
        child: Stack(
          children: [
            Consumer<CarProvider>(builder: (context, provider, child) {
              return SizedBox(
                height: 100.h,
                width: 100.w,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: 35.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(provider.currentCar!.image!),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.red,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.w),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: SizedBox(
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CarTitle(
                                    title: provider.currentCar!.name,
                                    category: context.read<CategoryProvider>().getCategoryName(provider.currentCar!.categoryId),
                                  ),
                                  const Spacer(),
                                  SpecWidget(
                                    title: "Rate Per Day",
                                    isLast: true,
                                    content: provider.currentCar!.rate.toString(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              CarSpecifications(
                                year: provider.currentCar!.year.toString(),
                                manufacturer: provider.currentCar!.manufacturer,
                                model: provider.currentCar!.model,
                                mileage:
                                    provider.currentCar!.mileage.toString(),
                                seats: provider.currentCar!.seats.toString(),
                                fuel: provider.currentCar!.fuel,
                              ),
                              SizedBox(height: 3.h),
                              InsuranceSelector(),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: CButton(
                  title: "Book Now",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarBooking(),
                      ),
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
