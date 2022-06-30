import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:intl/intl.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:jiffy/jiffy.dart';

class CDatePicker extends StatefulWidget {
  final String title;
  final String value;
  final Function(String) onSelected;
  final DateTime firstDate;
  const CDatePicker({
    Key? key,
    required this.title,
    this.value = '',
    required this.onSelected,
    required this.firstDate,
  }) : super(key: key);

  @override
  State<CDatePicker> createState() => _CDatePickerState();
}

class _CDatePickerState extends State<CDatePicker> {
  DateTime selectedDate = DateTime.now();
  String selectedDateString = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: widget.firstDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        selectedDate = picked;
        selectedDateString = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _selectDate(context);
        widget.onSelected(selectedDateString);
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
