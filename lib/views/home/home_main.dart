import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/providers/booking_provider.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/map_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';
import 'package:wandering_wheels/views/home/home_cars.dart';
import 'package:wandering_wheels/views/home/home_categories.dart';
import 'package:wandering_wheels/views/home/widgets/car_card.dart';
import 'package:wandering_wheels/views/home/widgets/greetings_widget.dart';
import 'package:wandering_wheels/views/home/widgets/search_widget.dart';
import 'package:wandering_wheels/widgets/heading.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      context.read<MapProvider>().getLocation(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.h,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Consumer<CarProvider>(builder: (context, carProvider, child) {
              return Column(
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
                        SearchWidget(
                          controller: searchController,
                          isSearching: carProvider.isSearching,
                          onSearch: (val) {
                            carProvider.searchCars(val);
                          },
                        ),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ),
                  carProvider.isSearching
                      ? SizedBox(
                          height: 80.h,
                          width: 100.w,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 3.h,
                            ),
                            itemCount: carProvider.searchedCars.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return CarCard(
                                carName: carProvider.searchedCars[index].name,
                                carImage:
                                    carProvider.searchedCars[index].image!,
                                carRate: carProvider.searchedCars[index].rate
                                    .toString(),
                                onTap: () {
                                  carProvider.setCurrentCar(
                                      carProvider.searchedCars[index]);
                                  Navigator.pushNamed(
                                    context,
                                    CarDetails.routeName,
                                  );
                                },
                              );
                            }),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 3.h, left: 3.h),
                              child: const Heading(
                                title: "Choose Car",
                                subtitle: "Choose your car from the list below",
                              ),
                            ),
                            SizedBox(height: 1.h),
                            const HomeCars(),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 3.h, left: 3.h, top: 3.h),
                              child: const Heading(
                                title: "Choose Category",
                                subtitle: "Find a car from catergory list",
                              ),
                            ),
                            SizedBox(height: 1.h),
                            const HomeCategory(),
                          ],
                        ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
