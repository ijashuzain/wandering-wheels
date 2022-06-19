import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:wandering_wheels/providers/auth_provider.dart';
import 'package:wandering_wheels/providers/booking_provider.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/cardetails_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/providers/home_provider.dart';
import 'package:wandering_wheels/providers/insurance_provider.dart';
import 'package:wandering_wheels/providers/map_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  ChangeNotifierProvider(create: (_) => InsuranceProvider()),
  ChangeNotifierProvider(create: (_) => CarDetailsProvider()),
  ChangeNotifierProvider(create: (_) => CarProvider()),
  ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ChangeNotifierProvider(create: (_) => BookingProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => MapProvider()),
];
