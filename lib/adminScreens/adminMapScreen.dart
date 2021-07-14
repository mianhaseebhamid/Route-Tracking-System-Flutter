import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:route_tracking_system/widgets/adminMaps.dart';

class AdminMapScreen extends StatefulWidget {
  // Variables for Getting Latitude, Longitude and Location from Home Screen
  final String routeCollection;
  final String routeTime;
  final String route;

  AdminMapScreen({this.routeCollection, this.routeTime, this.route});

  @override
  _AdminMapScreenState createState() => _AdminMapScreenState();
}

class _AdminMapScreenState extends State<AdminMapScreen> {


  double awayLat = 30.2411231;
  double awayLong = 71.536026;



  Location location = new Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  var id;

  Future<LocationData> getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    locationData = await location.getLocation();
    return locationData;
  }

  //Google Map Controller
  GoogleMapController mapController;

  //Markers and Polylines for Google Map
  Map<MarkerId, Marker> markers = {};

  //Init State of the Screen
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //AppBar in the Screen
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: purpleColor,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          title: Text(
            "Your Route",
            style: titleStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),

        //Body of the Screen
        body: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection("routeLocation")
                .where('route', isEqualTo: widget.routeCollection)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      child: Column(
                      children: [
                        //Widget that Will Show Information About Route
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(text: 'Your Route: ', style: greenStyle),
                          TextSpan(
                              text: widget.route,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.black)),
                        ])),

                        //Widget for Spacing
                        SizedBox(height: 20),

                        //Container that Contains Google Map Widget
                        Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: MapView(),
                        ),
                      ],
                    ));
            }));
  }
}
