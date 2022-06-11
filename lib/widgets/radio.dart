import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CRadio extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final Function(int) onChanged;
  const CRadio({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Radio(
          activeColor: kPrimaryColor,
          value: value,
          groupValue: groupValue,
          onChanged: (val) {
            onChanged(int.parse(val.toString()));
          },
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: kSecondaryColor,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }
}