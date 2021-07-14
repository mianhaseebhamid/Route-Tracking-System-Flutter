import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  double awayLat = 30.3547957;
  double awayLong = 71.5260851;
  
  var colId;

  LatLng currentPosition;
  final Completer<GoogleMapController> _controller = Completer();

  Marker origin;
  Marker destination;

  Set<Marker> markers = {};
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }



  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      if (origin == null || (origin != null && destination != null)) {
        setState(() {
          origin = Marker(
              markerId: MarkerId('mylocation'),
              infoWindow: InfoWindow(title: "My Location"),
              position: currentPosition,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
          );

          destination = Marker(
              markerId: MarkerId('routelocation'),
              infoWindow: InfoWindow(title: "Route Location"),
              position: LatLng(awayLat, awayLong),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
          );

        });
      }

      else {
        setState(() {});
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: currentPosition != null
          ? GoogleMap(
        mapType: MapType.normal,
        markers: {
          if(origin !=null ) origin,
          if(destination !=null) destination
        },
        initialCameraPosition: CameraPosition(target: currentPosition, zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      )
          : SizedBox.shrink(),
    );
  }
}