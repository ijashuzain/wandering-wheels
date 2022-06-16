import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onSearch;
  final bool isSearching;
  final TextEditingController controller;
  SearchWidget({
    Key? key,
    required this.onSearch,
    this.isSearching = false,
    required this.controller,
  }) : super(key: key);

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
                controller: controller,
                onChanged: (val) {
                  onSearch(val);
                },
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
                  suffixIcon: isSearching
                      ? GestureDetector(
                          onTap: () {
                            controller.clear();
                            onSearch('');
                          },
                          child: const Icon(
                            Icons.close,
                            color: kPrimaryColor,
                          ),
                        )
                      : const Icon(
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
