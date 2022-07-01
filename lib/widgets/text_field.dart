import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isDisabled;
  final TextInputType? type;
  final isPassword;
  const CTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.isDisabled = false, this.type, this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
      child: TextFormField(
        controller: controller,
        enabled: !isDisabled,
        keyboardType: type,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,

          hintStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
          ),
        ),
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
