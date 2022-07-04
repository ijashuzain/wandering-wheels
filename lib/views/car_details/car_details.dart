import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/models/car_model.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/utils/providers.dart';
import 'package:wandering_wheels/views/car_details/car_booking.dart';
import 'package:wandering_wheels/views/car_details/car_create.dart';
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
  UserData? owner;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      Car car = context.read<CarProvider>().currentCar!;
      owner = await context.read<UserProvider>().getUser(car.dealerId);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(builder: (context, userProvider, child) {
        return SizedBox(
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
                                      category: context
                                          .read<CategoryProvider>()
                                          .getCategoryName(
                                              provider.currentCar!.categoryId),
                                    ),
                                    const Spacer(),
                                    SpecWidget(
                                      title: "Rate Per Day",
                                      isLast: true,
                                      content:
                                          provider.currentCar!.rate.toString(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                CarSpecifications(
                                  owner: owner ??
                                      UserData(
                                          name: "",
                                          email: "",
                                          phone: "",
                                          type: "",
                                          trackMe: false),
                                  regNumber: provider.currentCar!.regNumber,
                                  year: provider.currentCar!.year.toString(),
                                  manufacturer:
                                      provider.currentCar!.manufacturer,
                                  model: provider.currentCar!.model,
                                  mileage:
                                      provider.currentCar!.mileage.toString(),
                                  seats: provider.currentCar!.seats.toString(),
                                  fuel: provider.currentCar!.fuel,
                                  qty: provider.currentCar!.quantity,
                                  lat: double.parse(
                                      provider.currentCar!.pickupLat),
                                  lng: double.parse(
                                      provider.currentCar!.pickupLng),
                                ),
                                SizedBox(height: 3.h),
                                userProvider.currentUser!.type == "Admin"
                                    ? const SizedBox()
                                    : InsuranceSelector(),
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
              userProvider.currentUser!.type == "Admin"
                  ? Consumer<CarProvider>(builder: (context, provider, child) {
                      if (provider.currentCar!.dealerId !=
                          userProvider.currentUser!.id) {
                        return const SizedBox();
                      }
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: Consumer<CarProvider>(
                            builder: (context, provider, child) {
                              return CButton(
                                title: "Edit",
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CarCreate(
                                        car: provider.currentCar!,
                                        isUpdate: true,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    })
                  : Consumer<CarProvider>(
                      builder: (context, provider, child) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: provider.currentCar!.isAvailable!
                                ? CButton(
                                    title: "Book Now",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CarBooking(),
                                        ),
                                      );
                                    },
                                  )
                                : CButton(
                                    title: "Not Available",
                                    isDisabled: true,
                                    onTap: () {},
                                  ),
                          ),
                        );
                      },
                    )
            ],
          ),
        );
      }),
    );
  }
}
