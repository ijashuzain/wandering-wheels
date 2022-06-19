import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/map_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/views/authentication/login_page.dart';
import 'package:wandering_wheels/widgets/button.dart';
import 'package:wandering_wheels/widgets/text_field.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static String routeName = "/profile";
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserData? currentUser;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      context.read<UserProvider>().creatingUser;
      currentUser = context.read<UserProvider>().currentUser;

      nameController.text = currentUser?.name ?? '';
      emailController.text = currentUser?.email ?? '';
      phoneController.text = currentUser?.phone ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.only(top: 3.h, right: 3.h, left: 3.h),
                child: SizedBox(
                  width: 100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile & Settings",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        "Update your profile and settings",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: kSecondaryColor,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 3.h, left: 3.h),
                child: Column(
                  children: [
                    CTextField(
                      controller: nameController,
                      hint: "Name",
                    ),
                    CTextField(
                      controller: emailController,
                      hint: "Email",
                      isDisabled: true,
                    ),
                    CTextField(
                      controller: phoneController,
                      hint: "Phone",
                    ),
                    Consumer<UserProvider>(
                      builder: (context, provider, child) {
                        return CButton(
                          isDisabled: provider.creatingUser,
                          isLoading: provider.creatingUser,
                          title: "Update",
                          onTap: () {
                            currentUser!.name = nameController.text;
                            currentUser!.phone = phoneController.text;
                            provider.updateUser(
                              user: currentUser!,
                              onError: (val) {},
                              onSuccess: (val) {
                                Navigator.of(context).pop();
                                provider.fetchUser(
                                  userId: currentUser!.id!,
                                  onSuccess: (user) {
                                    log("User fetched");
                                  },
                                  onError: (err) {
                                    log(err);
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Divider(
                thickness: 1.h,
                color: Colors.grey[300],
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SettingsOption(
                      title: "Signout",
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false);
                      },
                    ),
                    Consumer<UserProvider>(builder: (context, provider, child) {
                      return Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Text(
                              "Track Me",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Spacer(),
                          provider.isUpdatingTracking
                              ? SizedBox(
                                height: 50,
                                width: 50,
                                  child: const CupertinoActivityIndicator())
                              : Switch(
                                  value: provider.isTrackingEnabled,
                                  onChanged: (val) async {
                                    await provider.updateTrack(val);
                                    context.read<UserProvider>().checkTrackingStatus(context);
                                  },
                                ),
                        ],
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingsOption({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      title: Text(
        title,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
          fontFamily: "Poppins",
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: kPrimaryColor,
      ),
    );
  }
}
