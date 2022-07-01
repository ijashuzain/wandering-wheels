import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:wandering_wheels/widgets/button.dart';

import '../../constants/colors.dart';

class CarPickupMap extends StatefulWidget {
  final bool isSelect;
  final double lat;
  final double lng;
  final Function(LatLng)? onSelected;
  const CarPickupMap(
      {Key? key,
      this.isSelect = false,
      this.lat = 0,
      this.lng = 0,
      this.onSelected})
      : super(key: key);

  @override
  State<CarPickupMap> createState() => _CarPickupMapState();
}

class _CarPickupMapState extends State<CarPickupMap> {
  Marker? marker;

  @override
  void initState() {
    if (widget.lat != 0 || widget.lng != 0) {
      marker = Marker(
        markerId: const MarkerId('locationId'),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarker,
      );
      setState(() {});
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
          "Pickup Location",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.lng),
              ),
              markers: marker != null ? {marker!} : {},
              onTap: (loc) {
                if (widget.isSelect) {
                  log(loc.toString());
                  marker = Marker(
                    markerId: const MarkerId('locationId'),
                    position: loc,
                    icon: BitmapDescriptor.defaultMarker,
                  );
                }
                setState(() {});
              },
            ),
            if(widget.isSelect) Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: CButton(
                  isDisabled: marker == null,
                  onTap: () {
                    Navigator.pop(context);
                    widget.onSelected!(marker!.position);
                  },
                  title: 'Select',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
