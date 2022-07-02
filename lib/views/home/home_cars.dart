import 'dart:developer';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';
import 'package:wandering_wheels/views/home/widgets/car_card.dart';

class HomeCars extends StatelessWidget {
  const HomeCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CarProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return SizedBox(
            height: 40.w,
            width: 100.w,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if (provider.allCars.isEmpty) {
          return SizedBox(
            height: 40.w,
            width: 100.w,
            child: Center(
              child: Text(
                "No cars found",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12.sp,
                ),
              ),
            ),
          );
        }
        return SizedBox(
          height: 40.w,
          width: 100.w,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: provider.allCars.length,
            itemBuilder: (context, index) {
              return CarCard(
                carName: provider.allCars[index].name,
                carImage: provider.allCars[index].image!,
                carRate: provider.allCars[index].rate.toString(),
                onTap: () {
                  provider.setCurrentCar(provider.allCars[index]);
                  Navigator.pushNamed(
                    context,
                    CarDetails.routeName,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
