import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:route_tracking_system/commonScreens/preferencesScreen.dart';
import 'package:route_tracking_system/userScreens/contactScreen.dart';
import 'package:route_tracking_system/userScreens/feedbackScreen.dart';
import 'package:route_tracking_system/userScreens/profileScreen.dart';
import 'package:route_tracking_system/userScreens/trackingScreen.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:route_tracking_system/utils/customDialogue.dart';
import 'package:route_tracking_system/utils/myIcons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Scaffold Key that will be Used to Handle Drawer Navigation Bar
  var scaffoldKey = GlobalKey<ScaffoldState>();

  //Variables that will Store the Location Collection for Location Fetching
  String routeCollection;
  String routeTime;
  String route;
  String myLocation;

  Location location = new Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

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


  //Function that will read Saved Location Collection of User
  readPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final key1 = 'time';
    final key2 = 'route';
    final key3 = 'routeCollection';
    setState(() {
      routeTime = prefs.getString(key1) ?? 0;
      route = prefs.getString(key2) ?? 0;
      routeCollection = prefs.getString(key3) ?? 0;
    });
  }

  //Init State that will Call ReadPrefs Function
  @override
  void initState() {
    super.initState();
    readPrefs();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Declaration of Scaffold Key which will handle the Navigation Drawer
      key: scaffoldKey,

      //Background Color of Scaffold/App
      backgroundColor:Colors.white.withOpacity(0.96),

      //Widget and Design for AppBar
      appBar: AppBar(
        elevation: 0,

        //Background Color of AppBar
        backgroundColor: Colors.transparent,

        //Leading Icon of AppBar
        leading: IconButton(
          onPressed: (){
            scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(
              Myicons.menu,
            color: purpleColor,
          ),
        ),

        //Title of App on AppBar
        title: Text("Bus Tracking System",
            // 'Bus Tracking System',
        style: titleStyle,
        ),

        //Centering the title of Application on AppBar
        centerTitle: true,

      ),
      //End of AppBar

      //Design and Widget for Drawer
      drawer: Drawer(
        //For Scrolling the AppBar for Small Screens
        child: SingleChildScrollView(
          //Column to Make the Vertical Layout in Drawer
          child: Column(
            children: [
              //Drawer Header of Navigation Drawer
              DrawerHeader(
                //For Centering the Layout of Drawer Header
                child: Center(
                  child:Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: purpleColor,
                      child: Icon(
                          Myicons.bus,
                          size: 40,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text('Bus Tracking System',
                    style:titleStyle,)
                  ],
                ),),
              ),
              ListTile(
                onTap: (){},
                tileColor: Colors.white,
                leading: Icon(
                  Myicons.star,
                  color: purpleColor,
                ),
                title: Text("Rate Us",
                style: normalStyle
                ),
                trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: greenColor
                ),
              ),
              Divider(),
              ListTile(
                onTap: (){},
                tileColor: Colors.white,
                leading: Icon(
                  Myicons.share,
                  color: purpleColor,
                ),
                title: Text("Share App",
                  style: normalStyle,
                ),
                trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: greenColor
                ),
              ),
              Divider(),
              ListTile(
                onTap: (){},
                tileColor: Colors.white,
                leading: Icon(
                  Icons.policy,
                  color: purpleColor,
                ),
                title: Text("Privacy Policy",
                  style: normalStyle,
                ),
                trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: greenColor
                ),
              ),
              SizedBox(height: 150),
              RichText(text: TextSpan(
                  children:[
                    TextSpan(
                        text: 'FYP by: ',
                        style:greenStyle ),
                    TextSpan(
                        text: 'Haseeb A. ',
                        style: namesStyle),
                    TextSpan(
                        text: '& ',
                        style: normalStyle),
                    TextSpan(text: 'Ahsan A.',
                        style: namesStyle)
                  ]
              )),


            ],
          ),
        ),
      ),

      //Body of Main Screen
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        children: [
          //Bus Tracking Layout Button
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TrackingScreen(
                    routeCollection: routeCollection,
                    routeTime: routeTime,
                    route: route,
                  )
              )
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: purpleColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Myicons.bus, size: 50,
                    color: purpleColor,
                  ),
                  SizedBox(height: 20),
                  Text("Track Bus",
                    style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),)
                ],
              ),
              ),
          ),

          //Profile Layout Button
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileScreen())
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: purpleColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Myicons.profile,
                    size: 50,
                    color: purpleColor,
                  ),
                  SizedBox(height: 20),
                  Text("My Profile",
                    style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),)
                ],
              ),
            ),
          ),

          //Preferences Layout Button
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PreferencesScreen())
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: purpleColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Myicons.settings,
                    size: 50,
                    color: purpleColor,
                  ),
                  SizedBox(height: 20),
                  Text("Preferences",
                    style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),)
                ],
              ),
            ),
          ),

          //Contact Us Layout Button
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ContactUsScreen())
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: purpleColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Myicons.contact_us,
                    size: 50,
                    color: purpleColor,
                  ),
                  SizedBox(height: 20),
                  Text("Contact Us",
                    style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),)
                ],
              ),
            ),
          ),

          //Feedback Layout Button
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FeedbackScreen())
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: purpleColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Myicons.feedback,
                    size: 50,
                    color: purpleColor,
                  ),
                  SizedBox(height: 20),
                  Text("Feedback",
                    style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),)
                ],
              ),
            ),
          ),

          //Logout Layout Button
          InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext) => LogoutOverlay(),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: purpleColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    size: 50,
                    color: purpleColor,
                  ),
                  SizedBox(height: 20),
                  Text("Logout",
                    style:TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
