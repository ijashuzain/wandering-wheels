import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/insurance_provider.dart';
import 'package:wandering_wheels/widgets/underlined_titile.dart';

class InsuranceSelector extends StatelessWidget {
  InsuranceSelector({Key? key}) : super(key: key);

  InsuranceProvider insuranceProvider = InsuranceProvider();

  @override
  Widget build(BuildContext context) {
    insuranceProvider = context.read<InsuranceProvider>();
    return SizedBox(
      width: 100.w,
      child: Column(
        children: [
          const UnderlinedHeading("Select Insurance"),
          Selector<InsuranceProvider, int>(
            selector: (ctx, provider) => provider.selectedInsurance,
            builder: (contect, selectedInsurance, child) {
              return Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 90.w / 3,
                        child: Row(
                          children: [
                            Radio(
                              activeColor: kPrimaryColor,
                              value: 1,
                              groupValue: selectedInsurance,
                              onChanged: (val) {
                                insuranceProvider.selectInsurance(int.parse(val.toString()));
                              },
                            ),
                            Text(
                              "None",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: kSecondaryColor,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const InsuranceContent(
                        content: "Collision Damage Waiver",
                      ),
                      const InsuranceContent(
                        content: "Supplemental Liability Protection",
                      ),
                      const InsuranceContent(
                        content: "Personal Accedent Insurance",
                      ),
                      const InsuranceContent(
                        content: "Personal Effect Coverage",
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 90.w / 3,
                        child: Row(
                          children: [
                            Radio(
                              activeColor: kPrimaryColor,
                              value: 2,
                              groupValue: selectedInsurance,
                              onChanged: (val) {
                                insuranceProvider.selectInsurance(int.parse(val.toString()));
                              },
                            ),
                            Text(
                              "Basic",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: kSecondaryColor,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const InsuranceContent(
                        content: "Collision Damage Waiver",
                        isAvilable: true,
                      ),
                      const InsuranceContent(
                        content: "Supplemental Liability Protection",
                        isAvilable: true,
                      ),
                      const InsuranceContent(
                        content: "Personal Accedent Insurance",
                      ),
                      const InsuranceContent(
                        content: "Personal Effect Coverage",
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 90.w / 3,
                        child: Row(
                          children: [
                            Radio(
                              activeColor: kPrimaryColor,
                              value: 3,
                              groupValue: selectedInsurance,
                              onChanged: (val) {
                                insuranceProvider.selectInsurance(int.parse(val.toString()));
                              },
                            ),
                            Text(
                              "Premium",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: kSecondaryColor,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const InsuranceContent(
                        content: "Collision Damage Waiver",
                        isAvilable: true,
                      ),
                      const InsuranceContent(
                        content: "Supplemental Liability Protection",
                        isAvilable: true,
                      ),
                      const InsuranceContent(
                        content: "Personal Accedent Insurance",
                        isAvilable: true,
                      ),
                      const InsuranceContent(
                        isAvilable: true,
                        content: "Personal Effect Coverage",
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class InsuranceContent extends StatelessWidget {
  final String content;
  final bool isAvilable;
  const InsuranceContent({
    Key? key,
    required this.content,
    this.isAvilable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.w),
      child: SizedBox(
        width: 90.w / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              isAvilable ? Icons.done : Icons.close,
              color: isAvilable ? Colors.greenAccent : Colors.redAccent,
              size: 12.sp,
            ),
            SizedBox(width: 2.w),
            SizedBox(
              width: 72.w / 3,
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 7.sp,
                  fontWeight: FontWeight.w500,
                  color: kSecondaryColor,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
