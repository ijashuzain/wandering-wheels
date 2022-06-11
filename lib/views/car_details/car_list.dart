import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/views/car_details/car_create.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';
import 'package:wandering_wheels/views/home/widgets/car_card.dart';

class CarList extends StatelessWidget {
  static String routeName = "/car_list";

  final bool isEdit;
  final bool isCategory;
  const CarList({Key? key, this.isEdit = false, this.isCategory = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text(
          "Cars",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      floatingActionButton: isEdit
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, CarCreate.routeName);
              },
              child: const Icon(Icons.add),
              backgroundColor: kPrimaryColor,
            )
          : null,
      body: Consumer<CarProvider>(
        builder: (context, provider, child) {
          var cars = isCategory ? provider.categoryCars : provider.cars;
          if (provider.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (cars.isEmpty) {
            return  Center(
              child: Text(
                "No cars found",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12.sp,
                ),
              ),
            );
          }

          return SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                SizedBox(height: 3.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 3.h),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 3.h,
                      ),
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        return CarCard(
                          carName: cars[index].name,
                          carImage: cars[index].image!,
                          carRate: cars[index].rate.toString(),
                          onTap: () {
                            if (isEdit) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CarCreate(
                                    car: cars[index],
                                    isUpdate: true,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                CarDetails.routeName,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
