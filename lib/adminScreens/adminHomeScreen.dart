import 'package:flutter/material.dart';
import 'package:route_tracking_system/adminScreens/adminMapScreen.dart';
import 'package:route_tracking_system/adminScreens/busDetails.dart';
import 'file:///E:/My/route_tracking_system/lib/commonScreens/preferencesScreen.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:route_tracking_system/utils/customDialogue.dart';
import 'package:route_tracking_system/utils/myIcons.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminHomeScreen extends StatefulWidget {

  static const String idScreen = 'adminHomeScreen';

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  // Scaffold Key that will be Used to Handle Drawer Navigation Bar
  var scaffoldKey = GlobalKey<ScaffoldState>();

  //String that will Store the Location Collection for Location Fetching
  String routeCollection;
  String routeTime;
  String route;



  //Function that will read Saved Preferences of Admin App
  _readPrefs() async {
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
    _readPrefs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Background Color of Scaffold/App
      backgroundColor:Colors.white.withOpacity(0.96),

      //Widget and Design for AppBar
      appBar: AppBar(
        elevation: 0,

        //Background Color of AppBar
        backgroundColor: Colors.transparent,

        //Title of App on AppBar
        title: Text('Admin App ',
          style: titleStyle,
        ),

        //Centering the title of Application on AppBar
        centerTitle: true,

      ),
      //End of AppBar

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
                  builder: (context) => AdminMapScreen(
                    //Setters to Send Different Data to AdminMap Screen
                    routeCollection: routeCollection,
                    routeTime: routeTime,
                    route: route,

                  ))
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
                  Text("Start Route",
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
                  builder: (context) => BusDetailsScreen())
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
                    Icons.info_outline_rounded,
                    size: 50,
                    color: purpleColor,
                  ),
                  SizedBox(height: 20),
                  Text("Bus Details",
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
