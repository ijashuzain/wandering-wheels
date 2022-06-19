import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/starter.dart';
import 'package:wandering_wheels/utils/providers.dart';
import 'package:wandering_wheels/utils/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: kBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: providers,
          child: MaterialApp(
            title: 'Wheels',
            debugShowCheckedModeBanner: false,
            routes: routes,
            initialRoute: StarterPage.routeName,
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              backgroundColor: kBackgroundColor,
            ),
          ),
        );
      },
    );
  }
}
