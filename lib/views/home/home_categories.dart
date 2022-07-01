import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/views/car_details/car_list.dart';
import 'package:wandering_wheels/views/home/widgets/category_card.dart';
import 'package:sizer/sizer.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return SizedBox(
            height: 40.w,
            width: 100.w,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        } else if (provider.categories.isEmpty) {
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
        } else {
          log(provider.categories.length.toString());
          return SizedBox(
            width: 100.w,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  categoryName: provider.categories[index].name,
                  categoryImage: provider.categories[index].image,
                  avilableCars: "1",
                  onTap: () {
                    provider.setCurrentCatagory(provider.categories[index]);
                    context
                        .read<CarProvider>()
                        .fetchCarsByCategory(provider.categories[index],context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CarList(isCategory: true),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
