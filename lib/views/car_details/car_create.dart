import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/models/car_model.dart';
import 'package:wandering_wheels/models/category_model.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/views/car_details/car_pickupmap.dart';
import 'package:wandering_wheels/widgets/button.dart';
import 'package:wandering_wheels/widgets/image_picker.dart';
import 'package:wandering_wheels/widgets/text_field.dart';

class CarCreate extends StatefulWidget {
  static String routeName = "/car_create";

  final bool isUpdate;
  final Car? car;

  CarCreate({Key? key, this.isUpdate = false, this.car}) : super(key: key);

  @override
  State<CarCreate> createState() => _CarCreateState();
}

class _CarCreateState extends State<CarCreate> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController mileageController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController fuelController = TextEditingController();

  String? lat = '0';
  String? lng = '0';

  File? image;
  String? categoryId;
  List<DropdownMenuItem<String>> menuList = [];

  @override
  void initState() {
    image = null;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await _getCategories(context);
      if (widget.car != null) {
        bool result =
            await _checkCategoryAvailable(context, widget.car!.categoryId);
        if (result) {
          categoryId = widget.car!.categoryId;
        } else {
          categoryId = null;
        }
      }
    });
    if (widget.isUpdate) {
      displayNameController.text = widget.car?.name ?? '';
      categoryId = widget.car!.categoryId;
      rateController.text = widget.car?.rate.toString() ?? '';
      manufacturerController.text = widget.car?.manufacturer ?? '';
      modelController.text = widget.car?.model ?? '';
      yearController.text = widget.car?.year.toString() ?? '';
      mileageController.text = widget.car?.mileage.toString() ?? '';
      seatController.text = widget.car?.seats.toString() ?? '';
      quantityController.text = widget.car?.quantity.toString() ?? '';
      fuelController.text = widget.car?.fuel ?? '';
      regController.text = widget.car?.regNumber ?? '';
      lat = widget.car?.pickupLat ?? '0';
      lng = widget.car?.pickupLng ?? '0';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text(
          "Car",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.h, right: 3.h, bottom: 3.h),
              child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CImagePicker(
                        isUpdate: widget.isUpdate,
                        networkImage:
                            widget.car != null ? widget.car!.image : "",
                        onImagePicked: (img) {
                          log(img.path);
                          setState(() {
                            image = img;
                          });
                        },
                      ),
                      CTextField(
                        controller: displayNameController,
                        hint: "Display Name",
                      ),
                      DropdownButton(
                        value: categoryId,
                        items: menuList,
                        isExpanded: true,
                        hint: Text(
                          "Category",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                        onChanged: (val) {
                          log(val.toString());
                          setState(() {
                            categoryId = val.toString();
                          });
                        },
                      ),
                      CTextField(
                          type: TextInputType.number,
                          controller: rateController,
                          hint: "Rate Per Day"),
                      CTextField(
                          controller: manufacturerController,
                          hint: "Manufacturer"),
                      CTextField(controller: modelController, hint: "Model"),
                      CTextField(
                          type: TextInputType.number,
                          controller: yearController,
                          hint: "Year"),
                      CTextField(
                          controller: mileageController, hint: "Mileage"),
                      CTextField(
                          controller: regController,
                          hint: "Registration Number"),
                      CTextField(
                          type: TextInputType.number,
                          controller: seatController,
                          hint: "Seats"),
                      CTextField(controller: fuelController, hint: "Fuel"),
                      CTextField(
                          type: TextInputType.number,
                          controller: quantityController,
                          hint: "Quantity Of Vehicles"),
                      CButton(
                          expand: true,
                          title: lat == '0' || lng == '0'
                              ? "Select Pickup Location"
                              : "Change Pickup Location",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CarPickupMap(
                                    lat: double.parse(lat!),
                                    lng: double.parse(lng!),
                                    isSelect: true,
                                    onSelected: (loc) {
                                      setState(() {
                                        lat = loc.latitude.toString();
                                        lng = loc.longitude.toString();
                                      });
                                    },
                                  );
                                },
                              ),
                            );
                          }),
                      SizedBox(height: 3.h),
                      Consumer<CarProvider>(
                          builder: (context, provider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CButton(
                              isLoading: provider.isUploadingCar,
                              isDisabled: provider.isUploadingCar,
                              title: widget.isUpdate ? "Update" : "Create",
                              onTap: () {
                                if (displayNameController.text == '' ||
                                    categoryId == null ||
                                    rateController.text == '' ||
                                    manufacturerController.text == '' ||
                                    modelController.text == '' ||
                                    yearController.text == '' ||
                                    mileageController.text == '' ||
                                    seatController.text == '' ||
                                    fuelController.text == '' ||
                                    lat == null ||
                                    lng == null ||
                                    regController.text == '' ||
                                    quantityController.text == '') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        "Oops",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: kPrimaryColor,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      content: Text(
                                        "Please fill all fields",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: kSecondaryColor,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (!widget.isUpdate && image == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        "Oops",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: kPrimaryColor,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      content: Text(
                                        "Please select image",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: kSecondaryColor,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  UserData user =
                                      context.read<UserProvider>().currentUser!;
                                  provider.uploadCar(
                                    context: context,
                                    isUpdate: widget.isUpdate,
                                    currentImage: widget.car != null
                                        ? widget.car!.image
                                        : null,
                                    image: image,
                                    car: Car(
                                      dealerId: user.id!,
                                      pickupLat: lat.toString(),
                                      pickupLng: lng.toString(),
                                      regNumber: regController.text,
                                      name: displayNameController.text,
                                      rate: int.parse(rateController.text),
                                      categoryId: categoryId.toString(),
                                      manufacturer: manufacturerController.text,
                                      model: modelController.text,
                                      year: int.parse(yearController.text),
                                      mileage:mileageController.text,
                                      seats: int.parse(seatController.text),
                                      quantity:
                                          int.parse(quantityController.text),
                                      fuel: fuelController.text,
                                      id: widget.car == null
                                          ? ""
                                          : widget.car!.id,
                                      image: widget.car == null
                                          ? ""
                                          : widget.car!.image,
                                    ),
                                    onSuccess: (va) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            "Completed",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kPrimaryColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          content: Text(
                                            "Car updation was successfully completed.",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kSecondaryColor,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onError: (val) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            "Something went wrong",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kPrimaryColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          content: Text(
                                            val.toString(),
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kSecondaryColor,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                            if (widget.isUpdate)
                              CButton(
                                isLoading: provider.isDeletingCar,
                                isDisabled: provider.isDeletingCar,
                                title: "Delete",
                                onTap: () {
                                  provider.deleteCar(
                                    context: context,
                                    car: widget.car!,
                                    onSuccess: (va) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            "Deleted",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kPrimaryColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          content: Text(
                                            "Car deletion was successfully completed.",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kSecondaryColor,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onError: (val) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            "Something went wrong",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kPrimaryColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          content: Text(
                                            val.toString(),
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: kSecondaryColor,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                          ],
                        );
                      }),
                      SizedBox(height: 15.h)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<DropdownMenuItem<String>>> _getCategories(
      BuildContext context) async {
    await context.read<CategoryProvider>().fetchCategories();
    var categories = context.read<CategoryProvider>().categories;
    menuList = [];
    for (var element in categories) {
      menuList.add(
        DropdownMenuItem(
          child: Text(element.name),
          value: element.id,
        ),
      );
    }
    setState(() {});
    return menuList;
  }

  Future<bool> _checkCategoryAvailable(
      BuildContext context, String categoryId) async {
    var categories = context.read<CategoryProvider>().categories;
    Category? category = categories.firstWhere(
        (element) => element.id == categoryId,
        orElse: () => Category(id: "1", name: "NONE", image: "NONE"));
    if (category.id == "1") {
      return false;
    } else {
      return true;
    }
  }
}
