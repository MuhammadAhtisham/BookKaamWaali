import 'package:bookkaamwaali/register_login_screen/phone_signIn.dart';
import 'package:bookkaamwaali/register_login_screen/registerInfo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'dart:async';

class OtpScreen extends StatefulWidget {

  String var1, var2;
  OtpScreen({Key? key  , required this.var1, required this.var2}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref();
  FirebaseFirestore  dbref = FirebaseFirestore.instance;

  TextEditingController otpController = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  late String errorMessage;

  int secondsRemaining = 60;
  late Timer? timer;

  int? _resendToken;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      }
      if(secondsRemaining == 1)
      {
        Fluttertoast.showToast(
          msg: "Time Out",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
         Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneSignIn()));
      }
    });
  }

  @override
  void dispose() {
    setState(() {
      timer!.cancel();
    });
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          iconSize: 30.0,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneSignIn()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height:250.0,
                  width: MediaQuery.of(context).size.width,
                  color:Colors.pink,
                  child:Padding(
                    padding:EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          'Verification Code',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                        Text(
                          'We have sent you a code ',
                          style: TextStyle(
                            color:Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //positioned
                Container(
                  margin: EdgeInsets.only(top:150.0),
                  width: MediaQuery.of(context).size.width,
                  height: 750.0,
                  decoration: BoxDecoration(

                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.white,
                        Colors.blueAccent,
                      ],
                    ),

                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:60.0),
                      Text(
                        'Enter the 6-digit code we sent to ',
                        style: TextStyle(
                          fontSize: 20.0,
                          color:Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height:5.0),
                      Text(widget.var2,
                        style: TextStyle(
                          fontSize: 20.0,
                          color:Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height:50.0),
                      Padding(
                        padding:EdgeInsets.all(10.0),
                        child: PinCodeTextField(
                        autofocus: false,
                        controller: otpController,
                        hideCharacter: false,
                        highlight: false,
                        // highlightColor: Colors.blue,
                        highlightPinBoxColor: Colors.white,
                        defaultBorderColor: Colors.black26,
                        pinBoxColor: Colors.white,
                        hasTextBorderColor: Colors.pink,
                        pinBoxBorderWidth: 2.0,
                        pinBoxWidth: 54.0,
                        pinBoxRadius: 10.0,
                        pinBoxHeight: 65.0,
                        maxLength: pinLength,
                        hasError: hasError,
                        // maskCharacter: "🐶",
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                            thisText = text;
                          });
                        },
                        isCupertino: true,
                        onDone: (text) {
                        print("DONE $text");
                        },
                        wrapAlignment: WrapAlignment.end,
                        pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                        pinTextStyle: TextStyle(fontSize: 40.0, color: Colors.pink, fontWeight: FontWeight.w400),
                        pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Time Left: $secondsRemaining seconds',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF818589),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 250.0, top: 100),
                          // alignment: Alignment.centerRight,
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.pink,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10.0, // soften the shadow
                                spreadRadius: 2.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              ),
                            ],

                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(0.0),
                            child: InkWell
                            (
                              onTap: () {
                                setState(() {
                                  this.thisText = otpController.text;
                                  verifyOTP();
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen())
                                });
                                },
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(top: 30,bottom: 40,right:20,),
      //   height: 80.0,
      //   width: 80.0,
      //   child: FittedBox(
      //     child: FloatingActionButton(
      //       backgroundColor: Colors.pink,
      //       hoverColor: Colors.blue,
      //       elevation: 20.0,
      //       onPressed: () {
      //         null;
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.only(left: 5.0),
      //         child: Icon(
      //           Icons.arrow_forward_ios,
      //           color: Colors.white,
      //           size: 28.0,
      //         ),
      //       ),
      //     ),
      //
      //   ),
      // ),
    );
  }

  PBD(borderColor, pinBoxColor, {borderWidth, radius}) {


  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential = await auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null && secondsRemaining != 0) {
         // await ref.child("Registered Numbers").push().set({
         // "phoneNo": FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
         // });


         await dbref.collection("RegisteredNumbers").doc(auth.currentUser!.uid).set(
         {
               "phoneNo": auth.currentUser!.phoneNumber.toString(),
         });
         setState(() {
           timer!.cancel();
         });
         Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterInfo(var1: widget.var2)));
      }
    }
    on FirebaseAuthException catch (e) {
      print("catch");
      if(otpController.text.length==6  && secondsRemaining != 0) {
        Fluttertoast.showToast(
          msg: "Wrong Pin",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }
  void verifyOTP() async {
    PhoneAuthCredential phoneAuthCredential =
    PhoneAuthProvider.credential(verificationId: widget.var1, smsCode: otpController.text);

    print(widget.var1);
    if(otpController.text.length==0 && secondsRemaining!=0 )
    {
      Fluttertoast.showToast(
          msg: "Please Enter PIN",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    if(otpController.text.length < 6 && secondsRemaining!=0 )
    {
      Fluttertoast.showToast(
          msg: "Incomplete Code",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else
    {
      signInWithPhoneAuthCredential(phoneAuthCredential);
    }
  }
}

// FirebaseAuth.instance.authStateChanges()
// .listen((User? user) {
// if (user == null) {
// print('User is currently signed out!');
// } else {
// // !!!!! Here you know the user is signed-in !!!!!
// print('User is signed in!');
// }
// });

