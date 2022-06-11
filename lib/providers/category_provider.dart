import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wandering_wheels/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  bool isLoading = false;
  bool isUploadingImage = false;
  bool isUploadingCategory = false;
  Category? currentCategory;

  FirebaseFirestore db = FirebaseFirestore.instance;

  void setCurrentCatagory(Category category) {
    currentCategory = category;
    notifyListeners();
  }

  fetchCategories() async {
    setLoading(true);
    var ref = await db.collection('categories').get();
    categories = [];
    for (var doc in ref.docs) {
      Category category = Category.fromJson(doc.data());
      categories.add(category);
      notifyListeners();
    }
    setLoading(false);
  }

  uploadCategory({
    bool isUpdate = false,
    String? currentImage,
    File? image,
    required String categoryName,
    required String categoryId,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setUploadingCategory(true);
    String url = '';
    if (isUpdate) {
      url = currentImage!;
    } else {
      url = await uploadCategoryImage(
        categoryId: categoryId,
        image: image,
      );
    }
    if (url != '') {
      Category category = Category(
        id: categoryId,
        name: categoryName,
        image: url,
      );
      try {
        await db.collection("categories").doc(categoryId).set(category.toMap());
        await fetchCategories();
        _setUploadingCategory(false);
        onSuccess("Category has created successfully");
      } catch (e) {
        _setUploadingCategory(false);
        onError(e.toString());
      }
    } else {
      _setUploadingCategory(false);
      onError("Error uploading image");
    }
  }

  Future<String> uploadCategoryImage({
    required String categoryId,
    File? image,
  }) async {
    _setUploadingImage(true);
    String url = '';
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child("categories/$categoryId.jpg");
    try {
      var result = await imageRef.putFile(image!);
      url = await result.ref.getDownloadURL();
      _setUploadingImage(false);
      return url;
    } on FirebaseException catch (e) {
      log(e.message.toString());
      _setUploadingImage(false);
      return url;
    }
  }

  void _setUploadingCategory(bool val) {
    isUploadingCategory = val;
    notifyListeners();
  }

  void _setUploadingImage(bool value) {
    isUploadingImage = value;
    notifyListeners();
  }

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
