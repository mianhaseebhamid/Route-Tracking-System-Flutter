import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:route_tracking_system/adminScreens/adminHomeScreen.dart';
import 'package:route_tracking_system/adminScreens/adminSignUp.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:route_tracking_system/utils/myIcons.dart';

class AdminLoginScreen extends StatefulWidget {
  static const String idScreen = 'adminloginscreen';

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _obscureText = true;

  String role;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),

      //Body of the Screen
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bus Icon in Container
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Center(
                  child: Icon(
                    Myicons.bus,
                    size: 100,
                    color: purpleColor,
                  ),
                ),
              ),

              //Space Between Widgets
              SizedBox(
                height: 30,
              ),

              //Welcome Text
              Text("Welcome to", style: normalStyle),

              //Introduction Text
              Text(
                "Bus Tracking System",
                style: headingStyle,
              ),

              //Space
              SizedBox(
                height: 10,
              ),

              //Instructions Text
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                    "Dear Admin Please log in to your Account by using Email and Password to Update Live Location",
                    style: smallStyle),
              ),

              //Space
              SizedBox(
                height: 20,
              ),

              //Form for Input Details
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please Enter a valid Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          hintText: "Enter your Email Address",
                          fillColor: Colors.purpleAccent,
                          hoverColor: Colors.purple,
                          labelText: "Enter your Email Address",
                          prefixIcon: const Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: const Icon(Icons.mail_outline_rounded)),
                          focusColor: Color.alphaBlend(
                              Colors.purpleAccent, Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: new TextFormField(
                          controller: passwordController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            if (value.length < 8) {
                              return 'Password Should 8 Characters Long';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            hintText: "Enter your 8 Digit Password",
                            fillColor: Colors.purpleAccent,
                            hoverColor: Colors.purple,
                            labelText: "Enter your 8 Digit Password",
                            prefixIcon: const Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: const Icon(Icons.lock_outline)),
                            suffixIcon: TextButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.only(left: 0, right: 0),
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: _toggle,
                              child: Text(_obscureText ? "Show" : "Hide"),
                            ),
                            focusColor:
                                Color.alphaBlend(Colors.purple, Colors.black),
                          ),
                          obscureText: _obscureText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Button for LogIn
              Padding(
                  padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Center(
                    child: Material(
                      //Wrap with Material
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 0,
                      color: purpleColor,
                      clipBehavior: Clip.antiAlias,
                      // Add This
                      child: MaterialButton(
                        minWidth: 200.0,
                        height: 50,
                        color: purpleColor,
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            try {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Transform.scale(
                                        scale: 0.1,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.greenAccent,
                                        ));
                                  });
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim())
                                  .then((value) async {
                                final User currentUser =
                                    FirebaseAuth.instance.currentUser;
                                if (currentUser != null) {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(currentUser.uid)
                                      .get()
                                      .then((value) {
                                    role = value.data()['role'];
                                  });

                                  if (role == "admin") {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminHomeScreen()),
                                        (route) => false);
                                  }
                                } else {
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(
                                      msg: "You are not Admin");
                                }
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "No user found for that email.");
                              } else if (e.code == 'wrong-password') {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg:
                                        "Wrong Password Provided for that User.");
                              }
                            } catch (e) {
                              print(e);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please fill Login Details");
                          }
                        },
                        child: Text(
                          'Login Now',
                          style: whiteStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),

              Padding(
                padding:
                    EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 10),
                child: Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Text(
                    "New Admin?",
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400),
                  ),
                  Expanded(child: Divider()),
                ]),
              ),

              Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Center(
                    child: Material(
                      //Wrap with Material
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 0,
                      color: purpleColor,
                      clipBehavior: Clip.antiAlias,
                      // Add This
                      child: MaterialButton(
                        minWidth: 200.0,
                        height: 50,
                        color: purpleColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminSignUpScreen()));
                        },
                        child: Text(
                          'Sign Up',
                          style: whiteStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
