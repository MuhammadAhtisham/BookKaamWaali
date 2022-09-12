import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:bookkaamwaali/home_screen/homescreen.dart';
import 'package:bookkaamwaali/register_login_screen/Login_options.dart';
import 'package:bookkaamwaali/register_login_screen/OTP_Code.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_auth/firebase_auth.dart';



class PhoneVerification1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var darkTheme = ThemeData.dark().copyWith(primaryColor: Colors.blue);

    return MaterialApp(
      // title: 'Demo',
      // themeMode: ThemeMode.dark,
      // darkTheme: darkTheme,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: PhoneVerification(),
        ),
      ),
    );
  }
}

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'PK';
  ///COUNTRY CODE AND FLAG
  PhoneNumber number = PhoneNumber(isoCode: 'PK');

  String phoneNumber='';


  Common obj_common= Common();

  TextEditingController otpController = TextEditingController();
  bool otpVisibility = false;
  String verificationIDReceived = "";
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginOptions()));
                  },
                  child: obj_common.appBarContainer(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 80.0, left: 15.0, right: 15.0),
                  child: Form(
                    key: formKey,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          /// heading_Container
                          Container(
                            child: obj_common.headingtextWidget('Verify your \nphone number'),
                          ),
                          SizedBox(height: 20),
                          /// SUBheading_Container
                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: obj_common.subheadingtextWidget('We have sent you an SMS with a code\nto your number'),
                          ),
                          SizedBox(height: 40),
                          InternationalPhoneNumberInput(
                            ///prints number as you type on textfield
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                              phoneNumber = number.phoneNumber.toString();
                            },

                            ///prints true (if correct) and false (if not correct)
                            onInputValidated: (bool value) {
                              print(value);
                            },

                            ///ways of showing country names
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: Colors.black),
                            initialValue: number,
                            textFieldController: controller,
                            formatInput: false,
                            keyboardType:
                                ///decimal for integer number and signed for + and -
                            TextInputType.numberWithOptions(signed: true, decimal: true),
                            inputBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF3E3E61),
                                  width: 1.5,
                            ),
                            ),
                          ),
                          SizedBox(height: 50),

                          //
                          // Visibility(
                          //   child: TextField(
                          //   controller: otpController,
                          //   decoration: InputDecoration(),
                          //   keyboardType: TextInputType.number,
                          // ),visible: otpVisibility,),

                          SizedBox(
                            width: 200,
                            height: 45,
                            child: ElevatedButton(
                              style: obj_common.btnStyleWidget(),
                              onPressed: ()async {
                                if(otpVisibility){
                                  // verifyOTP();
                                }
                                else{
                                  loginWithPhone();
                                }
                              },
                               child: obj_common.btntextWidget("Continue"),
                              //  child: obj_common.btntextWidget(otpVisibility==false ? "Verify" : "Login"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void loginWithPhone() async {
    // formKey.currentState!.validate();
    ///phone number authentication
    //verification
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      ///verificationCompleted
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        await auth.signInWithCredential(authCredential);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      },
      ///verificationFailed
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("The provided phone number is not valid."),
              actions: <Widget>[
                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      style: obj_common.btnStyleWidget(),
                      child: obj_common.btntextWidget("ok")),
                ),
              ],
            ),
          );
        }
      },
      //codeSent
      codeSent: (String verificationId, int? resendToken) async {
        otpVisibility = true;
        verificationIDReceived = verificationId;
        setState(() {});

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("Enter Verification Code From Text Message"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              // children: <Widget>[TextField(controller: _codeController)],
            ),
            actions: <Widget>[
              SizedBox(
                width: 90,
                height: 40,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).popUntil((route) => route.isFirst);
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> OTP(var1: verificationIDReceived)));
                    },
                    style: obj_common.btnStyleWidget(),
                    child: obj_common.btntextWidget("ok")),
              ),
            ],
          ),
        );
      },
      ///codeAutoRetrievalTimeout
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
      },
    );
  }
  //
  // void verifyOTP() async {
  //
  //   // FirebaseAuth auth = FirebaseAuth.instance;
  //   // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationIDReceived, smsCode: otpController.text);
  //   //
  //   // await auth.signInWithCredential(credential);
  //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
  //
  //
  //
  // }
}





