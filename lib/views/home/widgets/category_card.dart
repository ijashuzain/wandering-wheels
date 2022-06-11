import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/views/car_details/car_list.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  final String avilableCars;
  final VoidCallback onTap;
  const CategoryCard(
      {Key? key,
      required this.categoryName,
      required this.categoryImage,
      required this.avilableCars,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: GestureDetector(
        onTap: () {
          onTap();
        
        },
        child: SizedBox(
          height: 50.w,
          width: 100.w,
          child: Stack(
            children: [
              Container(
                height: 50.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: kGreyColor,
                  borderRadius: BorderRadius.circular(6),
                  image:  DecorationImage(
                    image: NetworkImage(categoryImage),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: kGreyColor,
                      blurRadius: 3,
                      spreadRadius: 3,
                      offset: Offset(4, -4),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: kGreyColor,
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.transparent,
                      Colors.white,
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: SizedBox(
                    width: 40.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            fontFamily: "Poppins",
                            shadows: const [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 3,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                        ),
                        Text(
                          "$avilableCars Cars Available",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: kSecondaryColor,
                            fontFamily: "Poppins",
                            shadows: const [
                              Shadow(
                                color: Colors.white,
                                blurRadius: 3,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
