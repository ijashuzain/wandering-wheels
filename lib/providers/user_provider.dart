import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/map_provider.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  bool creatingUser = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  UserData? currentUser;
  bool isTrackingEnabled = false;
  bool isUpdatingTracking = false;

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
        setTrackingStatus(currentUser!.trackMe);
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

  updateTrack(bool val) async {
    _setUpdatingTracking(true);
    try {
      await db
          .collection("users")
          .doc(currentUser!.id)
          .update({"trackMe": val});
      await fetchUser(
          userId: currentUser!.id!, onSuccess: (val) {}, onError: (err) {});
      _setUpdatingTracking(false);
    } catch (e) {
      await fetchUser(
          userId: currentUser!.id!, onSuccess: (val) {}, onError: (err) {});
      _setUpdatingTracking(false);
    }
  }

  checkTrackingStatus(BuildContext context) async {
    await fetchUser(
      userId: currentUser!.id!,
      onSuccess: (val) {
        if (currentUser!.trackMe) {
          context.read<MapProvider>().listenLocation(context);
        } else {
          context.read<MapProvider>().stopListeningLocation();
        }
      },
      onError: (err) {},
    );
  }

  void setTrackingStatus(bool val) {
    isTrackingEnabled = val;
    notifyListeners();
  }

  void _setUpdatingTracking(bool val) {
    isUpdatingTracking = val;
    notifyListeners();
  }

  void _setCreatingUser(bool val) {
    creatingUser = val;
    notifyListeners();
  }
}
