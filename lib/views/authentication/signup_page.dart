import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/auth_provider.dart';
import 'package:wandering_wheels/views/home/home_main.dart';
import 'package:wandering_wheels/widgets/auth_title.dart';
import 'package:wandering_wheels/widgets/button.dart';
import 'package:wandering_wheels/widgets/text_field.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  static String routeName = "/signup";
  SignupPage({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.h,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              const AuthTitle(
                title: "Sign Up",
                subtitle: "Please register into our app to continue",
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.h, right: 5.h),
                child: Column(
                  children: [
                    CTextField(
                      controller: nameController,
                      hint: "Name",
                    ),
                    CTextField(
                      controller: emailController,
                      hint: "Email",
                    ),
                    CTextField(
                      controller: phoneController,
                      hint: "Phone",
                    ),
                    CTextField(
                      controller: placeController,
                      hint: "Place",
                    ),
                    CTextField(
                      controller: passwordController,
                      hint: "Password",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 1.h,
              ),
              Consumer<AuthProvider>(builder: (context, provider, child) {
                return CButton(
                  title: "Signup",
                  isLoading: provider.signingUp,
                  isDisabled: provider.signingUp,
                  onTap: () async {
                    await provider.signup(
                      context: context,
                      email: emailController.text,
                      password: passwordController.text,
                      user: UserData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        type: "Member",
                      ),
                      onSuccess: (val) {
                        log(val);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Home.routeName,
                          ((route) => false),
                        );
                      },
                      onError: (val) {
                        log(val);
                      },
                    );
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
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(
              text: "to Signup now. ",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 8.sp,
                color: kPrimaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
