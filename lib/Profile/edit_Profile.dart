import 'package:bookkaamwaali/Design/BottomBar_Design.dart';
import 'package:bookkaamwaali/Profile/Profile.dart';
import 'package:bookkaamwaali/Profile/User_List.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bookkaamwaali/home_screen/homescreen.dart';
import 'package:sidebarx/sidebarx.dart';

import '../Design/SideBar_Drawer_Design.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  DatabaseReference database = FirebaseDatabase.instance.ref();

  Common obj_common = Common();

  FirebaseAuth userAuth =  FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFF5F5FA7),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
                      },
                      child: obj_common.appBarContainer(),
                    ),
                    ///Edit Profile
                    Container(
                      margin: EdgeInsets.only(left: 90),
                      child: Text("Edit Profile",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color : Colors.white,
                        ),),
                    ),
                  ],
                ),
                ///First Name
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: TextField(
                //     decoration: InputDecoration(
                //     border: InputBorder.none,
                //       filled: true,
                //       fillColor: Colors.blueGrey,
                //       // labelText: "First Name",
                //     ),
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: fnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ///Last Name
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: lnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ///Email
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ///Password
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ///Gender
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: genderController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Gender',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ///Age
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ///Submit Button
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async{
                      if(fnameController.text.isEmpty)
                      {
                        print('please enter First Name');
                        Fluttertoast.showToast(
                            msg: "please enter First Name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      if(lnameController.text.isEmpty)
                      {
                        print('please enter Last Name');
                        Fluttertoast.showToast(
                            msg: "please enter Last Name",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      if(emailController.text.isEmpty)
                      {
                        print('please enter Email');
                        Fluttertoast.showToast(
                            msg: "please enter Email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      if(genderController.text.isEmpty)
                      {
                        print('please enter Gender');
                        Fluttertoast.showToast(
                            msg: "please enter Gender",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      if(ageController.text.isEmpty)
                      {
                        print('please enter Age');
                        Fluttertoast.showToast(
                            msg: "please enter Age",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else{
                        await database.child("Edit Profile").child(userAuth.currentUser!.uid).update({
                          "First Name" : fnameController.text,
                          "Last Name" : lnameController.text,
                          "Email" : emailController.text,
                          "Password" : passwordController.text,
                        });
                      }
                    },
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
     // bottomNavigationBar: BottomBar(),
    );
  }
}
