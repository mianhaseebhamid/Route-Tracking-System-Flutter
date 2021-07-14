import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:route_tracking_system/adminScreens/adminHomeScreen.dart';
import 'package:route_tracking_system/adminScreens/adminLoginScreen.dart';
import 'package:route_tracking_system/userScreens/homeScreen.dart';
import 'package:route_tracking_system/userScreens/loginScreen.dart';

//Main Function of App that will Run our App
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//MyApp Class which will Return a Material App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Returning MaterialApp
    return MaterialApp(

      //Removing Debug Banner from App
      debugShowCheckedModeBanner: false,


      // Checking if First time of Admin or Admin is not Logged In then Show Login Screen else show Home Screen
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AdminLoginScreen.idScreen
          : AdminHomeScreen.idScreen,
      routes: {
        AdminHomeScreen.idScreen: (context) => AdminHomeScreen(),
        AdminLoginScreen.idScreen:(context) => AdminLoginScreen()
      },


      // Checking if First time of User or Not Logged In then Show Login Screen else show Home Screen
      // initialRoute: FirebaseAuth.instance.currentUser == null
      //     ? LoginScreen.idScreen
      //     : HomeScreen.idScreen,
      // routes: {
      //   HomeScreen.idScreen: (context) => HomeScreen(),
      //   LoginScreen.idScreen:(context) => LoginScreen()
      // },
    );
  }
}


