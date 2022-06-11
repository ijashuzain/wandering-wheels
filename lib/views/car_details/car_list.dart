import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/models/category_model.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/views/car_details/car_create.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';
import 'package:wandering_wheels/views/home/widgets/car_card.dart';

class CarList extends StatelessWidget {
  static String routeName = "/car_list";

  final bool isEdit;
  const CarList({Key? key, this.isEdit = false}) : super(key: key);

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
          if (provider.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
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
                      itemCount: provider.cars.length,
                      itemBuilder: (context, index) {
                        return CarCard(
                          carName: provider.cars[index].name,
                          carImage: provider.cars[index].image!,
                          carRate: provider.cars[index].rate.toString(),
                          onTap: () {
                            if (isEdit) {
                              Navigator.pushNamed(context, CarCreate.routeName);
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
