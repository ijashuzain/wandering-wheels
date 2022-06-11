import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CImagePicker extends StatefulWidget {
  final Function(File) onImagePicked;
  final bool isUpdate;
  final String? networkImage;

  CImagePicker({
    Key? key,
    required this.onImagePicked,
    this.isUpdate = false, this.networkImage,
  }) : super(key: key);

  @override
  State<CImagePicker> createState() => _CImagePickerState();
}

class _CImagePickerState extends State<CImagePicker> {
  File? image;
  String? imageUrl;

  Future pickImage({bool fromGallery = false}) async {
    try {
      final image = await ImagePicker().pickImage(
          source: fromGallery ? ImageSource.gallery : ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      widget.onImagePicked(this.image!);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    image = null;
    imageUrl = widget.networkImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          builder: (context) => Container(
            height: 23.h,
            width: 100.w,
            decoration: const BoxDecoration(
              color: kLiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 1.h, left: 3.h, right: 3.h, bottom: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      print("asdasd");
                      await pickImage();
                    },
                    child: SizedBox(
                      height: 3.h,
                      child: Center(
                        child: Text(
                          "Camera",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: "Poppins",
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () async {
                      await pickImage(fromGallery: true);
                    },
                    child: SizedBox(
                      height: 4.h,
                      child: Center(
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: "Poppins",
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: 3.h,
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: "Poppins",
                            fontSize: 12.sp,
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
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.h),
        child: Container(
          height: 25.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: kGreyColor,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: image == null
              ? widget.isUpdate && imageUrl != null
                  ? Stack(
                      children: [
                        SizedBox(
                          height: 25.h,
                          width: 100.w,
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 1.w, bottom: 1.w),
                            child: GestureDetector(
                              onTap: () {
                                image = null;
                                imageUrl = null;
                                setState(() {});
                              },
                              child: const CircleAvatar(
                                backgroundColor: kPrimaryColor,
                                child: Center(
                                  child: Icon(
                                    Icons.delete,
                                    color: kLiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Icon(
                      Icons.add,
                      color: kLiteColor,
                      size: 15.h,
                    )
              : Stack(
                  children: [
                    SizedBox(
                      height: 25.h,
                      width: 100.w,
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 1.w, bottom: 1.w),
                        child: GestureDetector(
                          onTap: () {
                            image = null;
                            setState(() {});
                          },
                          child: const CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            child: Center(
                              child: Icon(
                                Icons.delete,
                                color: kLiteColor,
                              ),
                            ),
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
