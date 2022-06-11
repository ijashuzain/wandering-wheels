import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CDatePicker extends StatefulWidget {
  final String title;
  final String value;
  final VoidCallback onSelected;
  const CDatePicker({
    Key? key,
    required this.title,
    
    this.value = '',
    required this.onSelected,
  }) : super(key: key);

  @override
  State<CDatePicker> createState() => _CDatePickerState();
}

class _CDatePickerState extends State<CDatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected();
      },
      child: SizedBox(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  widget.value == '' ? "Select Pickup Date" : widget.value,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w500,
                    color: kSecondaryColor,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.calendar_month_outlined)
          ],
        ),
      ),
    );
  }
}
