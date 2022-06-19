import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/booking_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';

class MapProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final loc.Location _location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getLocationStream(
      {required BuildContext context, required String userId}) {
    return db.collection("users").doc(userId).snapshots();
  }

  listenLocation(BuildContext context) async {
    log("ListenLocation");
    UserData user = context.read<UserProvider>().currentUser!;
    if (user.trackMe) {
      _locationSubscription =
          _location.onLocationChanged.handleError((onError) {
        _locationSubscription!.cancel();
        _locationSubscription = null;
        notifyListeners();
        log(onError.toString());
      }).listen((location) async {
        await db.collection("users").doc(user.id).update({
          "latitude": location.latitude,
          "longitude": location.longitude,
        });
      });
    } else {
      log("Stopped listening");
    }
  }

  getLocation({
    required BuildContext context,
  }) async {
    try {
      UserData user = context.read<UserProvider>().currentUser!;
      final loc.LocationData location = await _location.getLocation();
      await db.collection("users").doc(user.id).update({
        "latitude": location.latitude,
        "longitude": location.longitude,
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  stopListeningLocation() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
    notifyListeners();
  }

  requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      log("Permission granted");
    } else if (status.isDenied) {
      requestPermission();
    }
  }
}
