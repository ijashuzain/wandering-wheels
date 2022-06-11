import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/providers/cardetails_provider.dart';
import 'package:wandering_wheels/widgets/radio.dart';
import 'package:sizer/sizer.dart';

class GenderWidget extends StatelessWidget {
  final Function(String) onSelected;
  const GenderWidget(
    this.onSelected, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CarDetailsProvider, int>(
      selector: (context, provider) => provider.selectedGender,
      builder: (context, selectedGender, child) {
        return SizedBox(
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CRadio(
                title: "Male",
                value: 1,
                groupValue: selectedGender,
                onChanged: (val) {
                  context.read<CarDetailsProvider>().selectGender(val);
                  onSelected("Male");
                },
              ),
              CRadio(
                title: "Female",
                value: 2,
                groupValue: selectedGender,
                onChanged: (val) {
                  context.read<CarDetailsProvider>().selectGender(val);
                  onSelected("Female");
                },
              ),
              CRadio(
                title: "Other",
                value: 3,
                groupValue: selectedGender,
                onChanged: (val) {
                  context.read<CarDetailsProvider>().selectGender(val);
                  onSelected("Other");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
