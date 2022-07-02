import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CRadio extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final bool isHorizontal;
  final Function(int) onChanged;
  const CRadio({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.isHorizontal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return Row(
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
    } else {
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
}
