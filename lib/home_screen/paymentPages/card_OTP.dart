import 'package:bookkaamwaali/home_screen/orders/OrderReceipt.dart';
import 'package:bookkaamwaali/home_screen/paymentPages/paymentByCard.dart';
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

class Card_OTP extends StatefulWidget {
  String service, allServices, gender, frequency, price, year, month, day, hour, repeat, employeeKey;
  int additionalPrice;
  Card_OTP({Key? key, required this.service, required this.allServices, required this.gender, required this.frequency,  required this.price, required this.additionalPrice, required this.year, required this.month, required this.day, required this.hour, required this.repeat, required this.employeeKey}) : super(key: key);


  @override
  State<Card_OTP> createState() => _Card_OTPState();
}

class _Card_OTPState extends State<Card_OTP> {

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
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCardPage(service: widget.service, allServices: widget.allServices, gender: widget.gender, frequency: widget.frequency, price: widget.price, additionalPrice: widget.additionalPrice, year: widget.year, month: widget.month, day: widget.day, hour: widget.hour , repeat: widget.repeat, employeeKey: widget.employeeKey.toString())),);
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
        toolbarHeight: 35,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 7),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 16),
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      color: Colors.blueAccent,
                    ),
                    child: Center(
                      child: Text(
                        "Verification Code",
                        style: TextStyle(color:Colors.white,fontSize: 40, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:150.0),
                    width: MediaQuery.of(context).size.width,
                    height: 750.0,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height:90.0),
                        Text(
                          'Enter the 6-digit code we have sent you ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color:Colors.grey,
                            fontWeight: FontWeight.w900,
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
                            hasTextBorderColor: Colors.blueAccent,
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
                            pinTextStyle: TextStyle(fontSize: 40.0, color: Colors.blueAccent, fontWeight: FontWeight.w400),
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
                            margin: EdgeInsets.only(left: 270.0, top: 170),
                            // alignment: Alignment.centerRight,
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: Colors.blueAccent,


                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(0.0),
                              child: InkWell
                                (
                                onTap: () {
                                  setState(() {
                                    if( otpController.text.length==6)
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderReceipt(service: widget.service, allServices: widget.allServices, gender: widget.gender, frequency: widget.frequency, price: widget.price, additionalPrice: widget.additionalPrice, year: widget.year, month: widget.month, day: widget.day, hour: widget.hour , repeat: widget.repeat, employeeKey: widget.employeeKey.toString())),);
                                    else{
                                      Fluttertoast.showToast(
                                        msg: "Enter Pin",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
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
      ),
    );
  }


}



