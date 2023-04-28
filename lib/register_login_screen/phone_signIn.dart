import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'package:bookkaamwaali/register_login_screen/otpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_database/firebase_database.dart';

class PhoneSignIn extends StatefulWidget {

  const PhoneSignIn({Key? key}) : super(key: key);

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {

  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  String phoneNumber='';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  String verificationIDReceived = "";
  int? _resendToken;
  String initialCountry = 'PK';
  bool _isLoading = false;
   // bool flag = false;


  FirebaseAuth auth = FirebaseAuth.instance;
  final dbref = FirebaseDatabase.instance.ref();

  ///responsive start
  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  double displayHeight(BuildContext context) {
    debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }
  ///end responsive


  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.white,
              Colors.blueAccent,
            ]
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.pink,
            iconSize: 30.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            // width: double.infinity,
            // height: MediaQuery.of(context).size.height,

            child: Column(
              children: <Widget>[
                SizedBox(height: 100.0,),
                /// heading - sign in
                Text(
                  'Sign In',
                  style: TextStyle(
                    color:Colors.pink,
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0,),
                /// sub heading
                Container(
                  //delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                    child: Text('Enter your phone number to continue \n we will send you OTP to verifiy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.pink, fontWeight: FontWeight.w400),),
                  ),
                ),
                SizedBox(height: 60.0,),
                ///phone number field
                Container(
                  width: displayWidth(context) * 0.8,
                  //delay: Duration(milliseconds: 400),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black.withOpacity(0.13)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  /// input fields form validator
                  child: Stack(
                    children: [
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
                        spaceBetweenSelectorAndTextField: 0,
                        countrySelectorScrollControlled: false,
                        ///ways of showing country names
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: number,
                        maxLength: 11,
                        cursorColor: Colors.black,
                        textFieldController: phoneController,
                        // inputDecoration: InputDecoration(
                        //   // suffix: Icon(FontAwesomeIcons.phone,
                        //   //   size: 15,
                        //   //   color: Colors.red,),
                        //   hintText: "Enter phone number",
                        //   border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(
                        //         Radius.circular(8)),
                        //   ),
                        // ),
                         formatInput: false,
                        ///decimal for integer number and signed for + and -
                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                        inputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                        ),
                        // onSaved: (PhoneNumber number) {
                        //   print('On Saved: $number');
                        // },
                      ),
                      Positioned(
                        left: 90,
                        top: 8,
                        bottom: 8,
                        child: Container(
                          height: 40,
                          width: 1,
                          color: Colors.black.withOpacity(0.13),
                        ),
                      )
                    ],
                  ),
                  ),
                ),
                SizedBox(height: 50,),
                /// get otp button
                Container(
                  width:200.0,
                  height:60.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 30.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 5  horizontally
                          0.0, // Move to bottom 5 Vertically
                        ),
                      ),
                    ],
                  ),
                  //delay: Duration(milliseconds: 600),
                  child: MaterialButton(
                    onPressed: () {


                      setState(() {
                        _isLoading = true;
                      });

                      Future.delayed(Duration(seconds: 6), () async {
                        setState(() {
                          _isLoading = false;
                        });
                        bool flag = await checkNumberIsRegistered(phoneNumber);
                        print(flag);
                        if(flag==true)
                        {

                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page()));
                        }
                        else {
                          loginWithPhone();
                        }
                      });
                    },
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: _isLoading  ? Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    ) :
                    Text("Next", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                  ),
                ),
                SizedBox(height: 20,),
                ///agree to conditions
                Container(
                  //delay: Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('By tapping "Next" you agree to ', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text('Terms and Conditions', style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
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
  Future<bool> getNumber(String num2) async {
    bool isNumberRegistered =  false;
    print("asif M");
    try {
      print("zara M");
      await dbref.child("RegisteredNumbers").once().then((data) {
        for (var i in data.snapshot.children) {
          String data = i.child("phoneNo").value.toString();
          print(num2);
          print(data);
          if (num2 == data) {
            isNumberRegistered = true;
            break;

          } else {
            isNumberRegistered = false;
          }
        }
      });
      if(isNumberRegistered==true)
      {
        print('hassan1');
        return Future<bool>.value(true);
      }
      else{
        print('hassan2');
        return Future<bool>.value(false);
      }
    } catch (e) {
      print('hassan');
      return  false;
    }
  }


  Future<bool> checkNumberIsRegistered(String number) async {
    bool stringFuture = await getNumber(number);
    bool message = stringFuture;
    return(message);
  }
  void loginWithPhone() async {
    print("majeed");
    // formKey.currentState!.validate();
    ///phone number authentication
    //verification
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      ///verificationCompleted
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        await auth.signInWithCredential(authCredential);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page()));
      },
      ///verificationFailed
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Center(child: Text("Invalid Number", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
              content: Text("The provided phone number is not valid"),
              actions: <Widget>[
                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Colors.pink,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      // side: BorderSide(color: Colors.black),
                      // elevation: 9.0,
                    ),
                    child: Text("Ok", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                  ),
                ),
              ],
            ),
          );
        }
      },

      //codeSent
      codeSent: (String verificationId, int? resendToken) async {
        verificationIDReceived = verificationId;
        _resendToken = resendToken;

        setState(() {});
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            // backgroundColor: Color(0xFF3c8492),
            // backgroundColor: Colors.black.withOpacity(0.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Center(child: Text("OTP CODE", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            content: Text("Enter Verification Code From Text Message"),
            actions: <Widget>[
              SizedBox(
                width: 90,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpScreen(var1: verificationId, var2: phoneNumber)));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    primary: Colors.pink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    // side: BorderSide(color: Colors.black),
                    // elevation: 9.0,
                  ),
                  child: Text("Ok", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                ),
              ),
            ],
          ),
        );
      },
      timeout: const Duration(milliseconds: 2000),
      forceResendingToken: _resendToken,
      ///codeAutoRetrievalTimeout
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
      },
    );
  }
}
