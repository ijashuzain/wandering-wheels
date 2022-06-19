import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/models/booking_model.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:wandering_wheels/providers/map_provider.dart';
import 'package:location/location.dart' as loc;

class BookingTrack extends StatefulWidget {
  final Booking? bookingData;
  static String routeName = "/rentals_track";
  BookingTrack({Key? key, this.bookingData}) : super(key: key);

  @override
  State<BookingTrack> createState() => _BookingTrackState();
}

class _BookingTrackState extends State<BookingTrack> {
  final loc.Location _location = loc.Location();
  late GoogleMapController _mapController;
  bool added = false;

  String imgurl = "https://www.fluttercampus.com/img/car.png";
  Uint8List? bytes;

  Marker? marker;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
          .buffer
          .asUint8List();

      marker = Marker(
        markerId: const MarkerId('id'),
        icon: BitmapDescriptor.fromBytes(bytes!),
      );
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: ListTile(
          title: Text(
            "Track",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
              fontSize: 12.sp,
            ),
          ),
          subtitle: Text(
            "${widget.bookingData!.driverName}, ${widget.bookingData!.car!.name}",
            style: TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              fontSize: 10.sp,
            ),
          ),
        ),
      ),
      body: Consumer<MapProvider>(builder: (context, provider, child) {
        if (marker == null || bytes == null) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        return SizedBox(
          height: 100.h,
          width: 100.w,
          child: Center(
            child: StreamBuilder(
              stream: provider.getLocationStream(
                context: context,
                userId: widget.bookingData!.userId,
              ),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (added) {
                  myMap(snapshot);
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else {
                  UserData user = UserData.fromJson(snapshot.data!.data()!);
                  return GoogleMap(
                    markers: {
                      marker!,
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(user.latitude!, user.longitude!),
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController controller) async {
                      log("map created");
                      _mapController = controller;
                      setState(() {
                        added = true;
                      });
                    },
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }

  myMap(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) async {
    log("myMap");
    await _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(snapshot.data!.data()!['latitude']!,
              snapshot.data!.data()!['longitude']!),
          zoom: 15,
        ),
      ),
    );
    setState(() {
      marker = Marker(
        markerId: const MarkerId('id'),
        icon: BitmapDescriptor.fromBytes(bytes!),
        position: LatLng(snapshot.data!.data()!['latitude']!,
            snapshot.data!.data()!['longitude']!),
      );
    });
  }
}
