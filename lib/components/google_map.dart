import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapSmall extends StatefulWidget {
  @override
  _MapSmallState createState() => _MapSmallState();
}

class _MapSmallState extends State<MapSmall> {
  Location location = new Location();
  GoogleMapController controller;
  static final LatLng center = const LatLng(-15.5016, -47.4248);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: CameraPosition(target: center),
    );
  }
}
