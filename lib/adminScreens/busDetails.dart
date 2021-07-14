import 'package:flutter/material.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:route_tracking_system/utils/myIcons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusDetailsScreen extends StatefulWidget {
  @override
  _BusDetailsScreenState createState() => _BusDetailsScreenState();
}

class _BusDetailsScreenState extends State<BusDetailsScreen> {

  //Variables that will Store different Information.
  String time;
  String route;
  String routeCollection;

  //Function to read Admin Prefs
  _readPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final key1 = 'time';
    final key2 = 'route';
    final key3 = 'routeCollection';
    setState(() {
      time = prefs.getString(key1) ?? 0;
      route = prefs.getString(key2) ?? 0;
      routeCollection = prefs.getString(key3) ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _readPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
     //AppBar of the Screen
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Bus Details', style: titleStyle,),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: purpleColor,
          ),
          onPressed: (){
            Navigator.pop(context, true);
          },
        ),
      ),

      //Body of the Screen
      body: SingleChildScrollView(
        child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Circle in the Center that will Show Icon
                  Center(
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: purpleColor,
                      child: Icon(
                        Myicons.bus,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),

                  //Widget for Spacing
                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        //Rich Text Widget to Show Route Name
                        RichText(
                            text: TextSpan(
                                children:[
                                  TextSpan(
                                      text: 'Route Name: ',
                                      style: normalStyle
                                  ),
                                  TextSpan(
                                      text: '$route',
                                      style: timeStyle),
                                ]
                            )),

                        // Widget for Spacing
                        SizedBox(height: 10),


                        //Rich Text Widget to Show Route Timing
                        RichText(
                            text: TextSpan(
                                children:[
                                  TextSpan(
                                      text: 'Route Time: ',
                                      style: normalStyle
                                  ),
                                  TextSpan(
                                      text: '$time',
                                      style: timeStyle),
                                ]
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )
      )
    );
  }
}
