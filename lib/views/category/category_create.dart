import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/models/category_model.dart';
import 'package:wandering_wheels/providers/category_provider.dart';
import 'package:wandering_wheels/widgets/button.dart';
import 'package:wandering_wheels/widgets/image_picker.dart';
import 'package:wandering_wheels/widgets/text_field.dart';

class CategoryCreate extends StatefulWidget {
  static String routeName = "/category_create";

  final bool isUpdate;
  final Category? category;

  CategoryCreate({Key? key, this.isUpdate = false, this.category})
      : super(key: key);

  @override
  State<CategoryCreate> createState() => _CategoryCreateState();
}

class _CategoryCreateState extends State<CategoryCreate> {
  TextEditingController categoryNameController = TextEditingController();

  File? image;

  @override
  void initState() {
    image = null;
    if (widget.isUpdate) {
      categoryNameController.text = widget.category?.name ?? '';
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
          "Category",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(3.h),
                  child: Column(
                    children: [
                      CImagePicker(
                        isUpdate: widget.isUpdate,
                        networkImage: widget.category != null
                            ? widget.category!.image
                            : "",
                        onImagePicked: (img) {
                          log(img.path);
                          setState(() {
                            image = img;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      CTextField(
                        controller: categoryNameController,
                        hint: "Category Name",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Consumer<CategoryProvider>(
                    builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CButton(
                        title: widget.isUpdate ? "Update" : "Create",
                        isLoading: provider.isUploadingCategory,
                        isDisabled: provider.isUploadingCategory,
                        onTap: () {
                          if (categoryNameController.text == '') {
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
                            provider.uploadCategory(
                              image: image,
                              isUpdate: widget.isUpdate,
                              currentImage: widget.isUpdate
                                  ? widget.category!.image
                                  : null,
                              categoryName: categoryNameController.text,
                              categoryId:
                                  widget.isUpdate ? widget.category!.id : "",
                              onSuccess: (val) {
                                log("Success");
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
                                      "Category updation was successfully completed.",
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
                                log(val);
                                image = null;
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
                          title: "Delete",
                          isLoading: provider.isDeleteingCategory,
                          isDisabled: provider.isDeleteingCategory,
                          onTap: () {
                            provider.deleteCategory(
                              categoryId: widget.category!.id,
                              onSuccess: (val) {
                                log("Success");
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
                                      "Category deletion was successfully completed.",
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
                        )
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
