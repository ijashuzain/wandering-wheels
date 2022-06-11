import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';
import 'package:wandering_wheels/views/car_details/car_list.dart';
import 'package:wandering_wheels/views/home/home_cars.dart';
import 'package:wandering_wheels/views/home/widgets/car_card.dart';
import 'package:wandering_wheels/views/home/widgets/category_card.dart';
import 'package:wandering_wheels/views/home/widgets/greetings_widget.dart';
import 'package:wandering_wheels/views/home/widgets/search_widget.dart';
import 'package:wandering_wheels/widgets/heading.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.h,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 3.h, left: 3.h, top: 3.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<UserProvider>(
                          builder: (context, provider, child) {
                        return Greeting(name: provider.currentUser!.name);
                      }),
                      SizedBox(height: 3.h),
                      const SearchWidget(),
                      SizedBox(height: 3.h),
                      const Heading(
                        title: "Choose Car",
                        subtitle: "Choose your car from the list below",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                const HomeCars(),
                Padding(
                  padding: EdgeInsets.only(right: 3.h, left: 3.h, top: 3.h),
                  child: const Heading(
                    title: "Choose Category",
                    subtitle: "Find a car from catergory list",
                  ),
                ),
                SizedBox(height: 1.h),
                Consumer<CategoryProvider>(builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }

                  if (provider.categories.isEmpty) {
                    return const Center(
                      child: Text("No categories found"),
                    );
                  }
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
                            provider
                                .setCurrentCatagory(provider.categories[index]);
                            context.read<CarProvider>().fetchCarsByCategory(
                                provider.categories[index]);
                            Navigator.pushNamed(context, CarList.routeName);
                          },
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

