import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:route_tracking_system/widgets/userMaps.dart';


class TrackingScreen extends StatefulWidget {
  //Strings for Getting Latitude, Longitude and Location from Home Screen
  final String routeCollection;
  final String routeTime;
  final String route;

  TrackingScreen({
    this.routeCollection,
    this.routeTime,
    this.route
  });

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {

  //Strings for Storing Away Latitude, Longitude and Location
  String collectionId;
  String myLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Track Bus",
          style: titleStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
            child: Column(
                    children: [
                      Text('Track Your Route', style: greenStyle),
                      SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: UserMapView(
                            awayLat: 30.3547957,
                            awayLong : 71.5260851
                        ),
                      ),
                    ],
                  )
      )
  );
  }

}
