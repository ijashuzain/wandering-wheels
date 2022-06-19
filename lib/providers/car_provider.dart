import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wandering_wheels/models/car_model.dart';
import 'package:wandering_wheels/models/category_model.dart';

class CarProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isUploadingImage = false;
  bool isUploadingCar = false;
  bool isDeletingCar = false;
  List<Car> searchedCars = [];
  List<Car> cars = [];
  List<Car> categoryCars = [];
  Car? currentCar;
  bool isSearching = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void setCurrentCar(Car car) {
    currentCar = car;
    notifyListeners();
  }

  void setIsSearching(bool isSearching) {
    this.isSearching = isSearching;
    notifyListeners();
  }

  //search from cars
  void searchCars(String searchQuery) async {
    setIsSearching(true);
    searchedCars = [];
    if (searchQuery.isEmpty) {
      setIsSearching(false);
      return;
    } else {
      setIsSearching(true);
      for (var car in cars) {
        if (car.name.toLowerCase().contains(searchQuery.toLowerCase())) {
          searchedCars.add(car);
          notifyListeners();
        }
      }
    }
    notifyListeners();
  }

  fetchCars() async {
    setCarLoading(true);
    var ref = await db.collection('cars').get();
    cars = [];
    for (var doc in ref.docs) {
      Car car = Car.fromJson(doc.data());
      cars.add(car);
      notifyListeners();
    }
    setCarLoading(false);
  }

  uploadCar({
    bool isUpdate = false,
    String? currentImage,
    File? image,
    required Car car,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setUploadingCar(true);
    String url = '';
    String id = '';
    if (isUpdate) {
      url = currentImage!;
      id = car.id!;
    } else {
      var docRef = db.collection("cars").doc();
      id = docRef.id;
      url = await uploadCarImage(
        carId: docRef.id,
        image: image,
      );
    }
    if (url != '') {
      car.image = url;
      car.id = id;
      try {
        await db.collection("cars").doc(id).set(car.toMap());
        await fetchCars();
        _setUploadingCar(false);
        onSuccess("Car has created successfully");
      } catch (e) {
        _setUploadingCar(false);
        onError(e.toString());
      }
    } else {
      _setUploadingCar(false);
      onError("Error uploading car");
    }
  }

  deleteCar({
    File? image,
    required Car car,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setDeletingCar(true);
    try {
      await db.collection("cars").doc(car.id).delete();
      await fetchCars();
      _setDeletingCar(false);
      onSuccess("Car has deleted successfully");
    } catch (e) {
      _setDeletingCar(false);
      onError(e.toString());
    }
  }

  Future<String> uploadCarImage({
    required String carId,
    File? image,
  }) async {
    _setUploadingImage(true);
    String url = '';
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child("cars/$carId.jpg");
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

  fetchCarsByCategory(Category category) async {
    await fetchCars();
    categoryCars =
        cars.where((element) => category.name == element.category).toList();
    notifyListeners();
  }

  void _setUploadingCar(bool val) {
    isUploadingCar = val;
    notifyListeners();
  }

  void _setDeletingCar(bool val) {
    isDeletingCar = val;
    notifyListeners();
  }

  void _setUploadingImage(bool val) {
    isUploadingImage = val;
    notifyListeners();
  }

  void setCarLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
