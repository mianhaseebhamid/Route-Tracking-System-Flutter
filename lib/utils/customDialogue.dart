import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_tracking_system/adminScreens/adminLoginScreen.dart';
import 'package:route_tracking_system/userScreens/loginScreen.dart';
import 'package:route_tracking_system/utils/colors.dart';


class LogoutOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 180.0,

              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:20, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Logout',
                          style:GoogleFonts.poppins(
                              textStyle:
                              TextStyle(fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),),
                        Padding(padding: EdgeInsets.only(top:10, bottom: 25),

                          child:
                          Text('Are you sure do you want to logout?',
                            style:GoogleFonts.poppins(textStyle:
                            TextStyle(fontSize: 13,
                                color: Color(0xff757E90))),),)
                        ,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right:15),
                              child: GestureDetector(
                                onTap: (){
                                  FirebaseAuth.instance.signOut();

                                  //If Building Admin App
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, LoginScreen.idScreen,
                                          (route) => false);


                                  // If Building User App
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, LoginScreen.idScreen,
                                          (route) => false);
                                },
                                child: Text('CONFIRM',
                                  textAlign: TextAlign.left,
                                  style:GoogleFonts.poppins(
                                      textStyle:
                                      TextStyle(fontSize: 14, color: purpleColor, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),


                            // Cancel Button
                            Padding(
                              padding: EdgeInsets.only(left:10),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context, true);
                                },
                                child: Text('CANCEL',
                                  textAlign: TextAlign.left,
                                  style:GoogleFonts.poppins(
                                      textStyle:
                                      TextStyle(fontSize: 14,
                                          color: Color(0xff757E90),
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ],
                        )


                      ],),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}