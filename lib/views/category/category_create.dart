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
  TextEditingController categoryIdController = TextEditingController();

  File? image;

  @override
  void initState() {
    image = null;
    if (widget.isUpdate) {
      categoryNameController.text = widget.category?.name ?? '';
      categoryIdController.text = widget.category?.id ?? '';
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
                        networkImage: widget.category != null ? widget.category!.image : "",
                        onImagePicked: (img) {
                          log(img.path);
                          setState(() {
                            image = img;
                          });
                        },
                      ),
                      CTextField(
                        controller: categoryNameController,
                        hint: "Category Name",
                      ),
                      CTextField(
                        isDisabled: widget.isUpdate ? true : false,
                        controller: categoryIdController,
                        hint: "Category ID",
                      )
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
                  return CButton(
                    title: "Submit",
                    isLoading: provider.isUploadingCategory,
                    isDisabled: provider.isUploadingCategory,
                    onTap: () {
                      provider.uploadCategory(
                        image: image,
                        isUpdate: image != null ? true : false,
                        currentImage: widget.category!.image,
                        categoryName: categoryNameController.text,
                        categoryId: categoryIdController.text,
                        onSuccess: (val) {
                          log("Success");
                          Navigator.pop(context);
                        },
                        onError: (val) {
                          log(val);
                          categoryNameController.clear();
                          categoryIdController.clear();
                          image = null;
                        },
                      );
                    },
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
