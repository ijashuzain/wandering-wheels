import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/views/home/home_cars.dart';
import 'package:wandering_wheels/views/home/home_categories.dart';
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
                const HomeCategory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


