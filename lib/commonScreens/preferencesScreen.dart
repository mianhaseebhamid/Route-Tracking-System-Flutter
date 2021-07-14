import 'package:flutter/material.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:route_tracking_system/utils/myIcons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {

  // Variables to Store different data
  var time;
  var route;
  var routeCollection;

  final snackBar = SnackBar(content: Text('Preferences Saved Successfully'));

  //Function for Saving Preferences
  _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final key1 = 'time';
    final key2 = 'route';
    final key3 = "routeCollection";
    time = time;
    route = route;
    routeCollection = routeCollection;
    prefs.setString(key1, time);
    prefs.setString(key2, route);
    prefs.setString(key3, routeCollection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),

      //AppBar of the Screen
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Preferences', style: titleStyle,),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: purpleColor,
          ),
          onPressed: () {
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
              Center(
                  child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: purpleColor,
                    child: Icon(
                      Myicons.settings,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),

                  Text('Save Your Prefs',
                    style: headingStyle,
                  ),
                ],
              )),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Class Time', style: smallStyle,),

                    // Drop Down Menu to Select Time
                    DropdownButtonFormField<String>(
                      dropdownColor: Colors.white.withOpacity(0.9),
                      value: "Please Select Time",
                      icon: Icon(Icons.arrow_downward, color: Colors.black),
                      iconSize: 22,
                      elevation: 10,
                      style: normalStyle,
                      onChanged: (var newValue) {
                        setState(() {
                          time = newValue;
                        });
                      },
                      onSaved: (var val) {
                        setState(() {
                          time = val;
                        });
                      },
                      isExpanded: true,
                      items: <String>[
                        'Please Select Time',
                        '1st Time',
                        '2nd Time',
                      ].map<DropdownMenuItem<String>>(
                            (var value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),

                    //Space
                    SizedBox(height: 20),

                    Text('Your Route', style: smallStyle),

                    // Drop Down Menu to Select Route
                    DropdownButtonFormField<String>(
                      dropdownColor: Colors.white.withOpacity(0.9),
                      value: "Please Select Route",
                      icon: Icon(Icons.arrow_downward, color: Colors.black),
                      iconSize: 20,
                      elevation: 16,
                      style: normalStyle,
                      onChanged: (var newValue) {
                        setState(() {
                          route = newValue;
                        });
                        
                      },
                      onSaved: (var val) {
                        setState(() {
                          route = val;
                        });
                      },
                      isExpanded: true,
                      items: <String>[
                        'Please Select Route',
                        'Garden Town',
                        'Chowk Kumharan Wala',
                        'Main Campus',
                        'City Campus'
                      ].map<DropdownMenuItem<String>>(
                        (var value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),

                    // Button to Save Prefs
                    Padding(
                        padding: EdgeInsets.only(top:50, left: 10, right: 10),
                        child: Center(
                          child: Material(  //Wrap with Material
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) ),
                            elevation: 0,
                            color: purpleColor,
                            clipBehavior: Clip.antiAlias, // Add This
                            child: MaterialButton(
                              minWidth: 500.0,
                              height: 50,
                              color: purpleColor,
                              onPressed: () async {
                                _savePrefs();
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                if(time =="1st Time" && route == "Garden Town"){
                                  setState(() {
                                    routeCollection = "firstGardenTown";
                                  });
                                }
                                else if(time =="1st Time" && route == "Chowk Kumharan Wala"){
                                  setState(() {
                                    routeCollection = "firstKumharanWala";
                                  });
                                }
                                else if(time =="1st Time" && route == "Main Campus"){
                                  setState(() {
                                    routeCollection = "firstMainCampus";
                                  });
                                }
                                else if(time =="1st Time" && route == "City Campus"){
                                  setState(() {
                                    routeCollection = "firstCityCampus";
                                  });
                                }
                                else if(time =="2nd Time" && route == "Garden Town"){
                                  setState(() {
                                    routeCollection = "secondGardenTown";
                                  });
                                }
                                else if(time =="2nd Time" && route == "Chowk Kumharan Wala"){
                                  setState(() {
                                    routeCollection = "secondKumharanWala";
                                  });
                                }
                                else if(time =="2nd Time" && route == "Main Campus"){
                                  setState(() {
                                    routeCollection = "secondMainCampus";
                                  });
                                }
                                else if(time =="2nd Time" && route == "City Campus"){
                                  setState(() {
                                    routeCollection = "secondCityCampus";
                                  });
                                }
                              },

                              child: Text('Save Now',
                                style: whiteStyle, textAlign: TextAlign.center,),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
