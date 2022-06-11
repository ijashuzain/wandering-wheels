import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wandering_wheels/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  bool creatingUser = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserData? currentUser;

  createUser({
    required UserData user,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setCreatingUser(true);
    try {
      await db.collection("users").doc(user.id).set(user.toMap());
      _setCreatingUser(false);
      onSuccess("User has created successfully");
    } catch (e) {
      _setCreatingUser(false);
      onError(e.toString());
    }
  }

  fetchUser({
    required String userId,
    required Function(UserData) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      var ref = await db.collection("users").doc(userId).get();
      if (ref.data() != null) {
        currentUser = UserData.fromJson(ref.data()!);
        onSuccess(currentUser!);
      } else {
        currentUser = null;
        onError("User not found");
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  updateUser({
    required UserData user,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setCreatingUser(true);
    try {
      await db.collection("users").doc(user.id).update(user.toMap());
      _setCreatingUser(false);
      onSuccess("User has updated successfully");
    } catch (e) {
      _setCreatingUser(false);
      onError(e.toString());
    }
  }

  void _setCreatingUser(bool val) {
    creatingUser = val;
    notifyListeners();
  }
}
