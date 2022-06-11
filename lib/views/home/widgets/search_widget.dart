import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 100.h,
      decoration: BoxDecoration(
        color: kGreyColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 2.w),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                cursorColor: kPrimaryColor,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                  ),
                  hintText: "Search",
                  suffixIcon: const Icon(
                    Icons.search,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
