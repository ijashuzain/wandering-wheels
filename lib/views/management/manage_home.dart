import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/cardetails_provider.dart';
import 'package:wandering_wheels/views/car_details/car_list.dart';
import 'package:wandering_wheels/views/category/category_list.dart';
import 'package:wandering_wheels/views/management/widgets/manage_option_big.dart';
import 'package:wandering_wheels/views/management/widgets/manage_option_small.dart';
import 'package:wandering_wheels/views/booking/booking_main.dart';
import 'package:provider/provider.dart';

class ManageHome extends StatelessWidget {
  static String routeName = '/manage_home';
  const ManageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.only(top: 3.h, right: 3.h, left: 3.h),
                child: SizedBox(
                  width: 100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Management",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        "Create and manage booking details ",
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
              Padding(
                padding: EdgeInsets.only(top: 3.h, right: 3.h, left: 3.h),
                child: ManageOptionBig(
                  title: "Bookings",
                  subtitle: "Total Bookings placed",
                  icon: Icons.car_rental,
                  onTap: () {
                    Navigator.pushNamed(context, BookingAll.routeName);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h, right: 3.h, left: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ManageOptionSmall(
                      title: "Categories",
                      subtitle: "Total categories",
                      icon: Icons.list,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryList(
                              isManage: true,
                            ),
                          ),
                        );
                      },
                    ),
                    ManageOptionSmall(
                      title: "Cars",
                      subtitle: "Total cars",
                      icon: Icons.car_repair_rounded,
                      onTap: () {
                        context.read<CarProvider>().fetchCars();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CarList(
                              isEdit: true,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
