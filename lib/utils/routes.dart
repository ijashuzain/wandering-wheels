import 'package:flutter/material.dart';
import 'package:wandering_wheels/views/authentication/login_page.dart';
import 'package:wandering_wheels/views/authentication/signup_page.dart';
import 'package:wandering_wheels/views/car_details/car_booking.dart';
import 'package:wandering_wheels/views/car_details/car_create.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';
import 'package:wandering_wheels/views/car_details/car_list.dart';
import 'package:wandering_wheels/views/category/category_create.dart';
import 'package:wandering_wheels/views/category/category_list.dart';
import 'package:wandering_wheels/views/home/home_main.dart';
import 'package:wandering_wheels/starter.dart';
import 'package:wandering_wheels/views/management/manage_home.dart';
import 'package:wandering_wheels/views/navigation/navigation.dart';
import 'package:wandering_wheels/views/profile/profile.dart';
import 'package:wandering_wheels/views/booking/booking_main.dart';
import 'package:wandering_wheels/views/booking/booking_track.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (_) => const StarterPage(),
  StarterPage.routeName: (_) => const StarterPage(),
  Home.routeName: (_) =>  Home(),
  LoginPage.routeName: (_) => LoginPage(),
  SignupPage.routeName: (_) => SignupPage(),
  CarDetails.routeName: (_) => CarDetails(),
  CarBooking.routeName: (_) => CarBooking(),
  Navigation.routeName: (_) => Navigation(),
  Profile.routeName: (_) => Profile(),
  CarList.routeName: (_) => CarList(),
  ManageHome.routeName: (_) => ManageHome(),
  BookingAll.routeName: (_) => BookingAll(),
  BookingTrack.routeName: (_) =>  BookingTrack(),
  CategoryList.routeName: (_) => CategoryList(),
  CategoryCreate.routeName: (_) => CategoryCreate(),
  CarCreate.routeName: (_) => CarCreate(),
};
