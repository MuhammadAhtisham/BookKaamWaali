import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:bookkaamwaali/register_login_screen/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:bookkaamwaali/home_screen/homescreen.dart';

import 'package:bookkaamwaali/register_login_screen/Login_options.dart';
import 'package:bookkaamwaali/register_login_screen/OTP_Code.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
class OTP extends StatefulWidget {
  String var1;
   OTP({Key? key, required this.var1} ) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  Common obj_common = Common();

  TextEditingController otpController = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  late String errorMessage;



  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                  },
                  child: obj_common.appBarContainer(),
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      obj_common.headingtextWidget('Phone Verfication'),
                      SizedBox(height: 20),
                      obj_common.subheadingtextWidget("Enter your OTP code here"),
                      Container(
                       width: 400,
                        // color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                           // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                                // child: Text(widget.var1),
                            ),
                            PinCodeTextField(
                              autofocus: false,
                              controller: otpController,
                              hideCharacter: false,
                              highlight: false,
                               highlightColor: Colors.white,
                              highlightPinBoxColor: Color(0xFF3E3E61),
                               defaultBorderColor: Colors.white,
                              pinBoxColor: Colors.black12,
                              hasTextBorderColor: Colors.white,
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
                              pinBoxDecoration: ProvidedPinBoxDecoration.roundedPinBoxDecoration,
                              pinTextStyle: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold),
                              pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                              pinTextAnimatedSwitcherDuration:
                              Duration(milliseconds: 300),
                            ),
                            Visibility(
                              child: Text(
                                "Wrong PIN!",
                                style: TextStyle(color: CupertinoColors.destructiveRed),
                              ),
                              visible: hasError,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                children: <Widget>[
                                  CupertinoButton(
                                   color: Color(0xFF3E3E61),
                                    // textColor: Colors.white,
                                    child: Text("SUBMIT"),
                                    onPressed: () {
                                      setState(() {
                                        this.thisText = otpController.text;
                                        verifyOTP();
                                      });
                                    },
                                  ),
//                                   CupertinoButton(
// //                      color: Colors.red,
// //                      textColor: Colors.white,
//                                     child: Text("SUBMIT Error"),
//                                     onPressed: () {
//                                       setState(() {
//                                         this.hasError = true;
//                                       });
//                                     },
//                                   )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                       SizedBox(height: 20),
                      Text('Didn\'t you recieve any code?',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF818589),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            'Resend a new code',
                            style: obj_common.TextStyleWidget(),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void verifyOTP() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.var1, smsCode: otpController.text);

    //await auth.signInWithCredential(credential);
    if(auth!=null)
      {
        print("invalid code");
      }
  }

}

///already registered
///timeout
///resend