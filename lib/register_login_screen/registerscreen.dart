import 'package:bookkaamwaali/Design/InputDeco_design.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:bookkaamwaali/register_login_screen/Login_options.dart';
import 'package:bookkaamwaali/register_login_screen/PhoneNumber_Verification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookkaamwaali/register_login_screen/loginscreen.dart';
import 'package:bookkaamwaali/home_screen/homescreen.dart';
import 'package:firebase_database/firebase_database.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


    TextEditingController nameController = TextEditingController();
    TextEditingController lnameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    late String fname, lname, phoneNumber, email, password, confirmPassword;
    final _formKey = GlobalKey<FormState>();

    final ref1 = FirebaseDatabase.instance.ref();

    FirebaseFirestore ref2 = FirebaseFirestore.instance;
    FirebaseAuth userAuth =  FirebaseAuth.instance;

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
                  margin: EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children:
                      [
                        /// Heading_Container
                        Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: obj_common.headingtextWidget('Create an Account'),
                        ),
                        /// firstName_Container
                        Container(
                          margin: EdgeInsets.only(top: 40.0, left: 10, right: 10),
                          child: TextFormField(
                             controller: nameController,
                            decoration:buildInputDecoration(Icons.person,"User Name"),
                            cursorColor: Color(0xFF3E3E61),
                            style: obj_common.TextStyleWidget(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter First Name';
                              }
                              // if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                              //   return 'Please enter Valid Email';
                              // }
                              return null;
                            },
                            onSaved: ( value){
                              fname = value!;
                            },
                          ),
                        ),

                        ///email_Container
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 10, right: 10),
                          child: TextFormField(
                            controller: emailController,
                            decoration:buildInputDecoration(Icons.email,"Email"),
                            cursorColor: Color(0xFF3E3E61),
                            style: obj_common.TextStyleWidget(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email or Phone Number';
                              }
                              // if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                              //   return 'Please enter Valid Email';
                              // }
                              return null;
                            },
                            onSaved: ( value){
                              phoneNumber = value!;
                            },
                          ),
                        ),
                        /// phone_Container
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 10, right: 10),
                          child: TextFormField(
                            controller: phoneNumberController,
                            decoration:buildInputDecoration(Icons.phone,"Phone Number"),
                            cursorColor: Color(0xFF3E3E61),
                            style: obj_common.TextStyleWidget(),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please Enter Email or Phone Number';
                            //   }
                            //   if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                            //     return 'Please enter Valid Email';
                            //   }
                            //   return null;
                            // },
                            // onSaved: ( value){
                            //   email = value!;
                            // },
                          ),
                        ),
                        /// password_Container
                        Container(
                          margin: EdgeInsets.only(top: 10.0, left: 10, right: 10),
                          child: TextFormField(
                            controller: passwordController,
                            decoration:buildInputDecoration(Icons.lock,"password"),
                            cursorColor: Color(0xFF3E3E61),
                            style: obj_common.TextStyleWidget(),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please Enter Email or Phone Number';
                            //   }
                            //   if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                            //     return 'Please enter Valid Email';
                            //   }
                            //   return null;
                            // },
                            // onSaved: ( value){
                            //   password = value!;
                            // },
                          ),
                        ),
                        /// Confirmpassword_Container
                        // Container(
                        //   margin: EdgeInsets.only(top: 10.0, left: 10, right: 10),
                        //   child: TextFormField(
                        //     // controller: confirmPasswordController,
                        //     decoration: InputDecoration(
                        //       border: UnderlineInputBorder(),
                        //       labelText: 'Confirm Password',
                        //     ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please Enter Email or Phone Number';
                        //   }
                        //   if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                        //     return 'Please enter Valid Email';
                        //   }
                        //   return null;
                        // },
                        // onSaved: ( value){
                        //   confirmPassword = value!;
                        // },
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.w600,
                        //       // color: Color(0xFF818589),
                        //     ),
                        //   ),
                        // ),
                        /// button_Container
                        /// await is used when your data is coming from or going through internet. it awaits until all data is send or received
                        Container(
                          margin: EdgeInsets.only(top: 50.0),
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            style: obj_common.btnStyleWidget(),
                            onPressed: () async{
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }


                              ///CreateUser
                              UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                              // await ref1.child("Edit Profile").child(userAuth.currentUser!.uid).set({
                              // "First Name" : nameController.text,
                              // "Email" : emailController.text,
                              // "Phone Number" : phoneNumberController.text,
                              // "Password" : passwordController.text,
                              // });

                              /// set user display name
                              var user=credential.user;
                              user!.updateDisplayName(nameController.text.trim());


                              await ref2..collection('User').doc(FirebaseAuth.instance.currentUser!.uid).set({
                                "uid" : FirebaseAuth.instance.currentUser!.uid,
                                "name" : nameController.text.trim(),
                                "email" : emailController.text.trim(),
                                "status" : "",
                              });
                              // _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneVerification1()));
                            },
                            child: obj_common.btntextWidget('Sign Up'),
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
