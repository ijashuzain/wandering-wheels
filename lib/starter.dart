import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/providers/map_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/views/authentication/login_page.dart';
import 'package:wandering_wheels/views/home/home_main.dart';
import 'package:wandering_wheels/views/navigation/navigation.dart';
import 'package:provider/provider.dart';

class StarterPage extends StatefulWidget {
  static String routeName = "/starter";
  const StarterPage({Key? key}) : super(key: key);

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      context.read<MapProvider>().requestPermission();
      await _checkLoggedIn(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.w,
                    width: 20.w,
                    child: Image.asset("assets/icons/ww-logo.png"),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  SizedBox(
                    height: 7.h,
                    width: 40.w,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Text(
                            "Wandering",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: kSecondaryColor,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.7.h,
                          child: Text(
                            "Wheels",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            const CupertinoActivityIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  _checkLogin(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) async {
        if (user == null) {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        } else {
          await context.read<UserProvider>().fetchUser(
                userId: user.uid,
                onSuccess: (user) async {
                  Navigator.pushReplacementNamed(
                    context,
                    Navigation.routeName,
                  );
                },
                onError: (val) {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginPage.routeName,
                  );
                },
              );
        }
      },
    );
  }

  _checkLoggedIn(BuildContext context) async {
    UserProvider provider = context.read<UserProvider>();
    bool res = await provider.checkLoggedIn();
    if (res) {
      UserData? user = provider.currentUser;
      if (user != null) {
        await context.read<CategoryProvider>().fetchCategories();
        await context.read<CarProvider>().fetchCars();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Navigation()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false);
    }
  }
}
