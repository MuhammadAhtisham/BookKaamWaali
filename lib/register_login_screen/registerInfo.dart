import 'package:bookkaamwaali/Design/InputDeco_design.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class RegisterInfo extends StatefulWidget {
  String var1;
  RegisterInfo({Key? key  , required this.var1}) : super(key: key);

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  Common obj_common = Common();
  late String _name, _email, _address, _selectedGender;
  final _formKey = GlobalKey<FormState>();


  final ref1 = FirebaseDatabase.instance.ref();
  FirebaseFirestore ref2 = FirebaseFirestore.instance;
  FirebaseAuth userAuth =  FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.blueAccent,
                    ]
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // InkWell(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                //   },
                //   child: Text("Skip"),
                // ),
                SizedBox(height: 100,),
                Container(
                  width: 325,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60,),
                        const Text(
                          'Hello, Have a good day',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Text("Please create Your Account",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),),
                        const SizedBox(height: 40,),
                        /// Name Container
                        Container(
                          width: 260,
                          height: 60,
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              suffix: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.purple,
                              size: 15),
                              labelText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8)),
                              ),
                            ),
                            inputFormatters: [FilteringTextInputFormatter.deny(RegExp("[0-9]+"))],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required Field';
                              }
                              if (!validator.name(value)) {
                                return 'Please enter full name and first letter in caps';
                              }
                              return null;
                            },
                            onSaved: (value){
                              _name = value.toString();
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        ///email_Container
                        Container(
                          width: 260,
                          height: 60,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              suffix: Icon(Icons.mail_outline_rounded,
                                color: Colors.purple,
                                  size: 15),
                              labelText: "Email Address",
                              hintText: "Optional",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              if(!validator.email(value))
                              {
                                return 'Please enter Valid Email';
                              }
                              return null;
                            },
                            onSaved: ( value){
                              _email = value.toString();
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        /// address_Container
                        Container(
                          width: 260,
                          height: 60,
                          child: TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              suffix: Icon(FontAwesomeIcons.addressCard,
                                color: Colors.purple,
                                  size: 15),
                              labelText: "Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Address';
                              }
                              return null;
                            },
                            onSaved: ( value){
                              _address = value.toString();
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        /// button Container
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            height:50,
                            width: 250,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.blueAccent,
                                      Colors.purple,
                                      Colors.blueAccent,
                                    ])
                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(5.0),
                              child: TextButton
                                (
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {

                                    _formKey.currentState?.save();
                                    FirebaseAuth.instance.sendSignInLinkToEmail(email: _email, actionCodeSettings: acs)
                                        .catchError((onError) {
                                      print('Error sending email verification $onError');

                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                          title: Center(child: Text("Verify Email", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
                                          content: Text("Error sending email verification"),
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
                                    }).then((value){ print('Successfully sent email verification');


                                    });


                                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')),);

                                    ///CreateUser
                                    // UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                                    await ref1.child("Users").child(userAuth.currentUser!.uid).set({
                                      "uid": FirebaseAuth.instance.currentUser!.uid,
                                      "name": nameController.text.trim(),
                                      "email": emailController.text.trim(),
                                      "phoneNumber": widget.var1.trim(),
                                      "address" : addressController.text.trim(),
                                      "status": "",
                                    });
                                    //
                                    //   SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
                                    //   await sharedPreferences.setString("uid", FirebaseAuth.instance.currentUser!.uid);
                                    //   await sharedPreferences.setString("name", nameController.text.trim(),);
                                    //   await sharedPreferences.setString("email", emailController.text.trim(),);
                                    //   await sharedPreferences.setString("phoneNumber", widget.var1.trim(),);
                                    //   /// set user display name
                                    //   var user= credential.user;
                                    //   user!.updateDisplayName(nameController.text.trim());

                                    await ref2.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                                      "uid": FirebaseAuth.instance.currentUser!.uid,
                                      "name": nameController.text.trim(),
                                      "email": emailController.text.trim(),
                                      "phoneNumber": widget.var1.trim(),
                                      "address": addressController.text.trim(),
                                      "status": "",
                                    });
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                        title: Center(child: Text("Verify Your Email", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
                                        content: Text("We have sent you email for verification"),
                                        actions: <Widget>[
                                          SizedBox(
                                            width: 90,
                                            height: 40,
                                            child: ElevatedButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page()));
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
                                child: Text('Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17,),
                        // Container(
                        //   margin: EdgeInsets.only(top: 50.0),
                        //   width: 350,
                        //   height: 50,
                        //   child: ElevatedButton(
                        //     style: obj_common.btnStyleWidget(),
                        //     onPressed: () async{
                        //       if (_formKey.currentState!.validate()) {
                        //
                        //         _formKey.currentState?.save();
                        //         FirebaseAuth.instance.sendSignInLinkToEmail(email: _email, actionCodeSettings: acs)
                        //             .catchError((onError) {
                        //               print('Error sending email verification $onError');
                        //
                        //               showDialog(
                        //                 context: context,
                        //                 barrierDismissible: false,
                        //                 builder: (context) => AlertDialog(
                        //                   title: Text("Error sending email verification ."),
                        //                   actions: <Widget>[
                        //                     SizedBox(
                        //                       width: 90,
                        //                       height: 40,
                        //                       child: ElevatedButton(
                        //                         onPressed: (){
                        //                           Navigator.of(context).pop();
                        //                           // Navigator.of(context).popUntil((route) => route.isFirst);
                        //                         },
                        //                         style: ElevatedButton.styleFrom(
                        //                           minimumSize: Size.fromHeight(50),
                        //                           primary: Color(0xFF3E3E61),
                        //                           // shadowColor: Colors.brown.withOpacity(1), //0 to 1 values
                        //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        //                           // side: BorderSide(color: Colors.black),
                        //                           // elevation: 9.0,
                        //                         ),
                        //                         child: Text("Ok",
                        //                           style: TextStyle(
                        //                             fontSize: 18.0,
                        //                             fontWeight: FontWeight.bold,
                        //                             color: Colors.white,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               );
                        //             })
                        //             .then((value){ print('Successfully sent email verification');
                        //
                        //         showDialog(
                        //           context: context,
                        //           barrierDismissible: false,
                        //           builder: (context) => AlertDialog(
                        //             title: Text("Successfully sent email verification"),
                        //             actions: <Widget>[
                        //               SizedBox(
                        //                 width: 90,
                        //                 height: 40,
                        //                 child: ElevatedButton(
                        //                   onPressed: (){
                        //                     Navigator.of(context).pop();
                        //                     Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                        //                     // Navigator.of(context).popUntil((route) => route.isFirst);
                        //                   },
                        //                   style: ElevatedButton.styleFrom(
                        //                     minimumSize: Size.fromHeight(50),
                        //                     primary: Color(0xFF3E3E61),
                        //                     // shadowColor: Colors.brown.withOpacity(1), //0 to 1 values
                        //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        //                     // side: BorderSide(color: Colors.black),
                        //                     // elevation: 9.0,
                        //                   ),
                        //                   child: Text("Ok",
                        //                     style: TextStyle(
                        //                       fontSize: 18.0,
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.white,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         );});
                        //
                        //
                        //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')),);
                        //
                        //         ///CreateUser
                        //         // UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                        //         await ref1.child("Users").child(userAuth.currentUser!.uid).set({
                        //           "uid": FirebaseAuth.instance.currentUser!.uid,
                        //           "name": nameController.text.trim(),
                        //           "email": emailController.text.trim(),
                        //           "phoneNumber": widget.var1.trim(),
                        //           "address" : addressController.text.trim(),
                        //           "status": "",
                        //         });
                        //       //
                        //       //   SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
                        //       //   await sharedPreferences.setString("uid", FirebaseAuth.instance.currentUser!.uid);
                        //       //   await sharedPreferences.setString("name", nameController.text.trim(),);
                        //       //   await sharedPreferences.setString("email", emailController.text.trim(),);
                        //       //   await sharedPreferences.setString("phoneNumber", widget.var1.trim(),);
                        //       //   /// set user display name
                        //       //   var user= credential.user;
                        //       //   user!.updateDisplayName(nameController.text.trim());
                        //
                        //         await ref2.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                        //             "uid": FirebaseAuth.instance.currentUser!.uid,
                        //             "name": nameController.text.trim(),
                        //             "email": emailController.text.trim(),
                        //             "phoneNumber": widget.var1.trim(),
                        //             "address": addressController.text.trim(),
                        //             "status": "",
                        //           });
                        //       }
                        //     },
                        //     child: obj_common.btntextWidget('Register'),
                        //   ),
                        // ),
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
  var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
      url: 'https://bookkaamwaali.page.link/',
      handleCodeInApp: true,
      iOSBundleId: 'com.google.firebase.flutterauth',
      androidPackageName: 'com.google.firebase.flutterauth',

      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');
}