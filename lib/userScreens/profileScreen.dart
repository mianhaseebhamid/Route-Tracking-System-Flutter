import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String time;
  String route;

  var fName, lName ;
  var vari;
  User user = FirebaseAuth.instance.currentUser;

  void getData() async {
    vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      fName = vari.data()['first_name'];
      lName = vari.data()['last_name'];

    });
  }

  void initState() {
    super.initState();
    getData();
    readPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Profile', style: titleStyle,),
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: purpleColor,
                  child : Icon(Icons.person_outline_rounded, size: 50, color: Colors.white,),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25 , bottom: 10),
                child: Stack(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text( "$fName " + "$lName",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              fontSize: 26),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            children:[
                              TextSpan(
                                  text: 'Selected Time: ',
                                  style: normalStyle
                              ),
                              TextSpan(
                                  text: '$time',
                                  style: timeStyle),
                            ]
                        )),
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(
                            children:[
                              TextSpan(
                                  text: 'Selected Route: ',
                                  style: normalStyle
                              ),
                              TextSpan(
                                  text: '$route',
                                  style: timeStyle),
                            ]
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

  void readPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final key1 = 'time';
    final key2 = 'route';
    setState(() {
      time = prefs.getString(key1) ?? 0;
      route = prefs.getString(key2) ?? 0;
    });
  }

}
