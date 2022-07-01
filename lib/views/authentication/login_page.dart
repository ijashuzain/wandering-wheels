import 'dart:developer';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/auth_provider.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/utils/globals.dart';
import 'package:wandering_wheels/views/authentication/signup_page.dart';
import 'package:wandering_wheels/views/home/home_main.dart';
import 'package:wandering_wheels/views/navigation/navigation.dart';
import 'package:wandering_wheels/widgets/auth_title.dart';
import 'package:wandering_wheels/widgets/button.dart';
import 'package:wandering_wheels/widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/login";
  LoginPage({Key? key}) : super(key: key);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text("Press back button again to close the app."),
        ),
        child: SizedBox(
          height: 100.h,
          width: 100.h,
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              const AuthTitle(
                title: "Login",
                subtitle: "Please login to enter into our app",
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                child: Column(
                  children: [
                    CTextField(
                      controller: usernameController,
                      hint: "Username",
                      type: TextInputType.emailAddress,
                    ),
                    CTextField(
                      type: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: passwordController,
                      hint: "Password",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SignupText(() {
                Navigator.pushNamed(context, SignupPage.routeName);
              }),
              SizedBox(
                height: 1.h,
              ),
              Consumer<AuthProvider>(builder: (context, provider, child) {
                return CButton(
                  title: "Login",
                  isLoading: provider.loggingIn,
                  isDisabled: provider.loggingIn,
                  onTap: () async {
                    if (usernameController.text == '' ||
                        passwordController.text == '') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "Oops",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kPrimaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          content: Text(
                            "Please fill all fields",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: kSecondaryColor,
                              fontSize: 10.sp,
                            ),
                          ),
                          actions: [
                            FlatButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      await provider.login(
                        email: usernameController.text,
                        password: passwordController.text,
                        onSuccess: (val) async {
                          await context.read<UserProvider>().fetchUser(
                                userId: val,
                                onSuccess: (val) async {
                                  await context
                                      .read<CategoryProvider>()
                                      .fetchCategories();
                                  await context.read<CarProvider>().fetchCars(context);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Navigation.routeName, ((route) => false));
                                },
                                onError: (val) {
                                  Globals.showCustomDialog(
                                      context: context,
                                      title: "Error",
                                      content: val);
                                  log(val);
                                },
                              );
                        },
                        onError: (val) {
                          Globals.showCustomDialog(
                              context: context,
                              title: "Error",
                              content: val);
                          log(val);
                        },
                      );
                    }
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class SignupText extends StatelessWidget {
  final VoidCallback onTap;
  const SignupText(
    this.onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't you have registered yet ? ",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 8.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: "Click here ",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 8.sp,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline),
            ),
            TextSpan(
              text: "to Signup now. ",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 8.sp,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
