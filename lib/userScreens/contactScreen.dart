import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_tracking_system/utils/colors.dart';
import 'package:route_tracking_system/utils/myIcons.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  //Variables to Store Different Data
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final auth = FirebaseAuth.instance.currentUser;
  String subject = '';
  String message = '';
  String userID;
  String listMessage;
  String fullName;

  final snackBar = SnackBar(content: Text('Message Sent Successfully'));

  //Function to Send Message
  _sendMessage() async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection('contactUs')
        .doc(auth.uid)
        .collection('messages')
        .doc(listMessage)
    ;
    return ref.set({
      'uid': auth.uid,
      'fullName': auth.displayName,
      'profileImage': auth.photoURL,
      'subject': _subjectController.text,
      'message': _messageController.text
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    subject = _subjectController.text;
    message = _messageController.text;
    return Scaffold(
      backgroundColor: Colors.white,

      //AppBar of the Screen
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Contact Us',
          style: titleStyle
        ),
        centerTitle: true,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios_outlined,
            color: Colors.black,),
          onPressed: (){
            Navigator.pop(context, true);
          },
        ),
      ),

      //Body of the Screen
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                      radius: 70,
                      backgroundColor: purpleColor,
                      child:Icon(Myicons.contact_us,
                        color: Colors.white, size: 70,)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: TextFormField(
                    controller: _subjectController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                      hintText: 'Subject Title',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                  child: TextFormField(
                    controller: _messageController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: 'Enter Your Message',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[200]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                    ),
                    maxLines: 10,
                    minLines: 5,
                    // controller: cpfcontroller,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Should you have any question, feel free to contact us any time. we will get back to you as soon as we can!', style:GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15), fontWeight: FontWeight.w400),),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 80),
                  child: Material(  //Wrap with Material
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) ),
                    elevation: 0,
                    color: purpleColor,
                    clipBehavior: Clip.antiAlias, // Add This
                    child: MaterialButton(
                      minWidth: 500.0,
                      height: 50,
                      color: purpleColor,
                      // To Implement
                      onPressed: () async {
                        _sendMessage();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          _subjectController.text = '';
                          _messageController.text = '';
                        });
                      },
                      child: Text('Submit', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                    ),
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
