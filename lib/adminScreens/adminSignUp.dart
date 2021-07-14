import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:route_tracking_system/adminScreens/adminHomeScreen.dart';
import 'package:route_tracking_system/utils/colors.dart';


class AdminSignUpScreen extends StatefulWidget {
  @override
  _AdminSignUpScreenState createState() => _AdminSignUpScreenState();
}

class _AdminSignUpScreenState extends State<AdminSignUpScreen> {
  TextEditingController emailinpt = new TextEditingController();
  TextEditingController passinpt = new TextEditingController();
  TextEditingController fnameinpt = new TextEditingController();
  TextEditingController lnameinpt = new TextEditingController();
  TextEditingController cpassinpt = new TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool passObscureText = true;
  bool cPassObscureText = true;

  String _password;

  String get input => null;

  // Toggles the password show status
  void passToggle() {
    setState(() {
      passObscureText = !passObscureText;
    });
  }

  void cPassToggle() {
    setState(() {
      cPassObscureText = !cPassObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Signup',
          style: namesStyle,),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RichText(
                  text: TextSpan(
                    text: 'Welcome to',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Admin',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                              fontSize: 17)),
                      TextSpan(
                          text: ' Team!',
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: fnameinpt,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            hintText: "Enter your First Name",
                            fillColor: Colors.purple,
                            hoverColor: Colors.purpleAccent,
                            labelText: "Enter Your First Name",
                            prefixIcon: const Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child:
                                const Icon(Icons.person_outline_rounded)),
                            focusColor: Color.alphaBlend(
                                Colors.purpleAccent,
                                Colors.black),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'First Name Should Not be Empty';
                            }
                            if (value.length < 3) {
                              return 'Atleast 3 Characters';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: lnameinpt,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            hintText: "Enter your Last Name",
                            fillColor: Colors.purple,
                            hoverColor: Colors.purpleAccent,
                            labelText: "Enter Your Last Name",
                            prefixIcon: const Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child:
                                const Icon(Icons.person_outline_rounded)),
                            focusColor: Color.alphaBlend(
                                Colors.purpleAccent, Colors.black),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Last Name Should Not be Empty';
                            }
                            if (value.length < 2) {
                              return 'Atleast 2 Characters';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: emailinpt,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            hintText: "Enter your Email Address",
                            fillColor: Colors.purple,
                            hoverColor: Colors.purpleAccent,
                            labelText: "Enter your Email Address",
                            prefixIcon: const Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: const Icon(Icons.email_outlined)),
                            focusColor: Color.alphaBlend(
                                Colors.purpleAccent, Colors.black),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter an Email';
                            }
                            if (!RegExp(
                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please Enter a Valid Email';
                            }
                            return null;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: passinpt,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            hintText: "Enter your 8 Digit Password",
                            fillColor: Colors.purple,
                            hoverColor: Colors.purpleAccent,
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
                                onPressed: passToggle,
                                child: Text(passObscureText ? "Show" : "Hide")),
                            focusColor: Color.alphaBlend(
                                Colors.purpleAccent, Colors.black),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter Your Password';
                            }
                            if (value.length < 8) {
                              return 'Password Should 8 Characters Long';
                            }

                            return null;
                          },
                          onSaved: (val) => _password = input,
                          obscureText: passObscureText,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: new TextFormField(
                          controller: cpassinpt,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            hintText: "Confirm Your Password",
                            fillColor: Colors.purple,
                            hoverColor: Colors.purpleAccent,
                            labelText: "Confirm your Password",
                            prefixIcon: const Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: const Icon(Icons.app_blocking_outlined)),
                            suffixIcon: TextButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                onPressed: cPassToggle,
                                child:
                                Text(cPassObscureText ? "Show" : "Hide")),
                            focusColor: Color.alphaBlend(
                                Colors.purpleAccent, Colors.black),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please re-enter password';
                            }

                            if (passinpt.text != cpassinpt.text) {
                              return "Password does not match";
                            }

                            return null;
                          },
                          onSaved: (val) => _password = input,
                          obscureText: cPassObscureText,
                        ),
                      ),

                      SizedBox(height: 30,),


                      Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Center(
                            child: Material(
                              //Wrap with Material
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 0,
                              color: purpleColor,
                              clipBehavior: Clip.antiAlias, // Add This
                              child: MaterialButton(
                                minWidth: 200.0,
                                height: 50,
                                color: purpleColor,
                                onPressed: () {
                                  if (_formkey.currentState.validate()) {
                                    signUp();
                                  }
                                  else
                                  {
                                    Fluttertoast.showToast(
                                        msg: "Please fill Correct Details");
                                  }
                                  //Navigator.pushNamed(context, '/home');
                                },
                                child: Text(
                                  'Signup',
                                  style: whiteStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 10),
                        child:
                        Row(
                            children: <Widget>[
                              Expanded(
                                  child: Divider()
                              ),
                              Text("Already Member ?", style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),),
                              Expanded(
                                  child: Divider()
                              ),
                            ]
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: Center(
                            child: Material(
                              //Wrap with Material
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 0,
                              color: purpleColor,
                              clipBehavior: Clip.antiAlias, // Add This
                              child: MaterialButton(
                                minWidth: 200.0,
                                height: 50,
                                color: purpleColor,
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text(
                                  'Login',
                                  style: whiteStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_password', _password));
  }

  Future signUp() async {
    String name, email, lname, password;
    if (passinpt.text.length < 8) {
      Fluttertoast.showToast(msg: "Password must be 8 Characters");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Transform.scale(
                scale: 0.1,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.greenAccent,
                ));
          });
      email = emailinpt.text;
      name = fnameinpt.text;
      lname = lnameinpt.text;
      password = passinpt.text;

      FirebaseAuth _auth = FirebaseAuth.instance;
      _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((signedInUser) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(signedInUser.user.uid)
            .set({
          'email': email,
          'first_name': name,
          'last_name': lname,
          'role': 'admin',
          'uid': signedInUser.user.uid,
        }).then((value) {
          if (signedInUser != null) {
            Fluttertoast.showToast(msg: "Sign Up Success");
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(
                    builder: (context)=> AdminHomeScreen()),
                    (route) => false);
          }
        }).catchError((e) {
          Fluttertoast.showToast(msg: "Some Details are not correct");
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }
  }
}

