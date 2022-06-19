import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/views/car_details/car_details.dart';

class CarCard extends StatelessWidget {
  final String carName;
  final String carImage;
  final String carRate;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  const CarCard(
      {Key? key,
      required this.carName,
      required this.carImage,
      required this.carRate,
      required this.onTap, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: SizedBox(
          height: 40.w,
          width: 30.w,
          child: Stack(
            children: [
              Container(
                height: 40.w,
                width: 30.w,
                decoration: BoxDecoration(
                  color: kGreyColor,
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: NetworkImage(carImage),
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
                height: 40.w,
                width: 30.w,
                decoration: BoxDecoration(
                  color: kGreyColor,
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
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
                  padding: EdgeInsets.all(2.w),
                  child: SizedBox(
                    width: 28.w,
                    child: Text(
                      carName,
                      style: TextStyle(
                        fontSize: 10.sp,
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
