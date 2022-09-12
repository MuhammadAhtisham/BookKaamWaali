import 'package:bookkaamwaali/ChatApp/ChatApp_HomeScreen.dart';
import 'package:bookkaamwaali/Design/InternectConnectivity_Design.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:bookkaamwaali/register_login_screen/Login_options.dart';
import 'package:bookkaamwaali/register_login_screen/forgetpassword.dart';
import 'package:flutter/material.dart';
import 'package:bookkaamwaali/register_login_screen/registerscreen.dart';
import 'package:bookkaamwaali/home_screen/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bookkaamwaali/Design/InputDeco_design.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///visible/invisible password
  bool _isObscure = false;
  bool isChecked = true;

  ///for validator
  late String email, password;
  final _formKey = GlobalKey<FormState>();

  ///Common Class variable
  Common obj_common = Common();

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
              margin: EdgeInsets.only(top: 100.0, left: 15.0, right: 15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// heading_Container
                    Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: obj_common.headingtextWidget('Log In'),
                    ),
                    /// email_Container
                    Container(
                      margin: EdgeInsets.only(top: 55.0),
                      child: TextFormField(
                        controller: emailController,
                        // keyboardType: TextInputType.text,
                        decoration:buildInputDecoration(Icons.email,"Email"),
                        cursorColor: Color(0xFF3E3E61),
                        style: obj_common.TextStyleWidget(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email or Phone Number';
                          }
                          if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                            return 'Please enter Valid Email';
                          }
                          return null;
                        },
                        onSaved: ( value){
                          email = value!;
                        },
                      ),
                    ),
                    /// password_Container
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: !_isObscure,
                        decoration: InputDecoration(
                          fillColor: Colors.black12, filled: true,
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock,
                            color: Color(0xFF3E3E61),),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: Color(0xFF3E3E61),
                                width: 1.5
                            ),
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.black12,
                              width: 0,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 18),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        cursorColor: Color(0xFF3E3E61),
                        style: obj_common.TextStyleWidget(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter password';
                          }
                          if (value.length < 7) {
                            return 'Incorrect password';
                          }
                          return null;
                        },
                        onSaved: ( value){
                          password = value!;
                        },
                      ),
                    ),
                    ///remember me
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (value){
                                  isChecked = !isChecked;
                                  setState(() {
                                  });
                                },
                              ),
                              Text("Remember Me",
                                style: obj_common.TextStyleWidget(),
                              ),
                            ],
                          ),
                          ///forget password
                          Container(
                            child: InkWell(
                              onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassword()));
                              },
                              child: Container(
                                child: Text(
                                  'Forgot Password?',
                                  style: obj_common.TextStyleWidget(),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// loginButton_Container
                    Container(
                      margin: EdgeInsets.only(top: 45.0),
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          style: obj_common.btnStyleWidget(),
                          onPressed: () async{
                            UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                              if(user != null)
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatAppHome()));
                              }

                            }
                            ///FlutterToast - work same as validator as email not entered
                            // if(emailController.text.isNotEmpty)
                            //   {
                            //     if(passwordController.text.isNotEmpty)
                            //       {
                            //         print('Done');
                            //         Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                            //       }
                            //     else{
                            //       print('please enter password');
                            //       Fluttertoast.showToast(
                            //           msg: "please enter password",
                            //           toastLength: Toast.LENGTH_SHORT,
                            //           gravity: ToastGravity.TOP,
                            //           timeInSecForIosWeb: 1,
                            //           backgroundColor: Colors.red,
                            //           textColor: Colors.white,
                            //           fontSize: 16.0
                            //       );
                            //     }
                            //   }
                            // else if(emailController.text.isEmpty && passwordController.text.isEmpty )
                            // {
                            //
                            //     print('please enter email and password');
                            //     Fluttertoast.showToast(
                            //         msg: "please enter email and password",
                            //         toastLength: Toast.LENGTH_SHORT,
                            //         gravity: ToastGravity.TOP,
                            //         timeInSecForIosWeb: 1,
                            //         backgroundColor: Colors.red,
                            //         textColor: Colors.white,
                            //         fontSize: 16.0
                            //     );
                            //   }
                            // else{
                            //   print('please enter email');
                            //   Fluttertoast.showToast(
                            //       msg: "please enter email",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP,
                            //       timeInSecForIosWeb: 1,
                            //       backgroundColor: Colors.red,
                            //       textColor: Colors.white,
                            //       fontSize: 16.0
                            //   );
                            // }
                          },
                          child:  obj_common.btntextWidget('Log In'),
                      ),
                    ),

                    /// register_Container
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// NoAccount_Container
                          Text('New User?',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF818589),
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              Get.to(RegisterScreen());
                              // Get.back();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign Up.',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// APK
/// two types of APK
/// one for lease such as uploading on  Play Store (build -> flutter -> Build APK) and one for testing (build -> flutter -> Build App Bundle)
/// C:\Users\zaraa\bookkaamwaali\build\app\outputs\flutter-apk then change app-release.apk to your project name
