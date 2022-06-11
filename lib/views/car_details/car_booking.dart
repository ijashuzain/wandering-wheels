import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/cardetails_provider.dart';
import 'package:wandering_wheels/views/car_details/widgets/gender_widget.dart';
import 'package:wandering_wheels/widgets/button.dart';
import 'package:wandering_wheels/widgets/date_picker.dart';
import 'package:wandering_wheels/widgets/radio.dart';
import 'package:wandering_wheels/widgets/text_field.dart';
import 'package:wandering_wheels/widgets/underlined_titile.dart';

class CarBooking extends StatelessWidget {
  static String routeName = "/car_booking";
  CarBooking({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: ListTile(
          title: Text("2020 Toyota Avalon"),
          subtitle: Text("Book your car"),
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    children: [
                      const UnderlinedHeading("Rental Date"),
                      SizedBox(height: 2.h),
                      CDatePicker(
                        onSelected: () {},
                        title: "Pickup Date",
                      ),
                      SizedBox(height: 2.h),
                      CDatePicker(
                        onSelected: () {},
                        title: "Return Date",
                      ),
                      SizedBox(height: 6.h),
                      const UnderlinedHeading("Driver Details"),
                      GenderWidget((val) {
                        //TODO
                      }),
                      CTextField(controller: nameController, hint: "Name"),
                      CTextField(controller: emailController, hint: "Email"),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: CButton(
                  title: "Book Now",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
