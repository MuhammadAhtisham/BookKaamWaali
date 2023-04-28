import 'package:bookkaamwaali/home_screen/history.dart';
import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'package:bookkaamwaali/home_screen/profilePage.dart';
import 'package:bookkaamwaali/home_screen/settings.dart';
import 'package:bookkaamwaali/register_login_screen/phone_signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({Key? key, required this.pageNumber}) : super(key: key);

  int pageNumber ;
  final ref = FirebaseDatabase.instance.ref();
  FirebaseAuth userAuth =  FirebaseAuth.instance;
  ///get Data function
  getData()async{
    final snapshot = await ref.child('Users').child(userAuth.currentUser!.uid).get();

    if(snapshot.exists){
      print(snapshot.value);
    }else{
      print('No Data Found');
    }
    return snapshot.value;
  }
  void closeDrawer(BuildContext context) {
    switch (pageNumber) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile_Page_Edit()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
        break;
      case 3:
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutPage(title: 'About')));
        break;
      case 4:
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactPage(title: 'Contact Us')));
        break;

    }
  }
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: Container(
        color: Color(0xFFe8f0fe),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder(
              future: getData(),
              builder:(builder , snapshot){
                if(!snapshot.hasData){
                  return UserAccountsDrawerHeader(
                    accountName: Text(""),
                    accountEmail: Text(""),
                    currentAccountPicture: InkWell(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage( "https://img.icons8.com/color/512/circled-user-male-skin-type-1-2--v1.png"),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile_Page_Edit()));
                      },
                    ),
                    decoration: BoxDecoration(
                       color: Color(0xFFe8f0fe),
                      // image: DecorationImage(
                        // image: NetworkImage(
                        //   "https://photo-cdn2.icons8.com/d57w-P0-EzgoU3qpQF0eKC8aSRAt7glzh_XKC5CbcPM/rs:fit:576:576/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5h/c3NldHMvYXNzZXRz/L3NhdGEvb3JpZ2lu/YWwvNjM3L2UwZDRm/NzcwLWJkYTgtNDcz/NC1iOTA4LWViMTJk/NGI3YzA2ZC5qcGc.webp",
                        // ),
                        // fit: BoxFit.fill,
                      // ),
                     ),
                    // otherAccountsPictures: [
                    //   CircleAvatar(
                    //     backgroundColor: Colors.white,
                    //     backgroundImage: NetworkImage(
                    //         ""),
                    //   ),
                    // ],
                  );

                }else{
                  Map <dynamic,dynamic> map = snapshot.data as Map<dynamic,dynamic>;
                  String name= map['name'];
                  // String lname= map['Last Name'];
                   String email= map['email'];
                  // String password= map['Password'];
                  return UserAccountsDrawerHeader(
                    accountName: Text(name, style: TextStyle(fontSize: 20,  color: Colors.black, fontWeight: FontWeight.bold)),
                    accountEmail: Text(email,  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                    currentAccountPicture: InkWell(
                      child:   CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            "https://img.icons8.com/color/512/circled-user-male-skin-type-1-2--v1.png"),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile_Page_Edit()));
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFe8f0fe),
                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //     "https://photo-cdn2.icons8.com/d57w-P0-EzgoU3qpQF0eKC8aSRAt7glzh_XKC5CbcPM/rs:fit:576:576/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5h/c3NldHMvYXNzZXRz/L3NhdGEvb3JpZ2lu/YWwvNjM3L2UwZDRm/NzcwLWJkYTgtNDcz/NC1iOTA4LWViMTJk/NGI3YzA2ZC5qcGc.webp",
                      //   ),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    // otherAccountsPictures: [
                    //   CircleAvatar(
                    //     backgroundColor: Colors.white,
                    //     backgroundImage: NetworkImage(
                    //         ""),
                    //   ),
                    // ],
                  );
                }
              }
            ),
            Divider(color: Colors.blue, thickness: 10),
            ListTile( //menu item of Drawer
              // leading: Icon(Icons.home, color: Color(0xFF2271b1)),
              leading: Image.network('https://img.icons8.com/color/2x/home.png', width: 35, height: 35),
              title: Text('Home'),
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page()));
              },
            ),
            ListTile(
              // leading: Icon(Icons.account_circle, color: Color(0xFF2271b1)),
              leading: Image.network('https://img.icons8.com/color/2x/male-female-user-group.png', width: 35, height: 35),
              title: Text('My Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile_Page_Edit()));
              },
            ),
            ListTile(
              // leading: Icon(Icons.settings, color: Color(0xFF2271b1)),
              leading: Image.network('https://img.icons8.com/color/2x/apple-settings.png', width: 35, height: 35),
              title: Text('Account Settings'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
              },
            ),
            ListTile( //menu item of Drawer
              // leading: Icon(Icons.home, color: Color(0xFF2271b1)),
              leading: Image.network('https://img.icons8.com/color/512/form.png', width: 35, height: 35),
              title: Text('History', ),
              onTap: (){
                ///History
                Navigator.push(context, MaterialPageRoute(builder: (context)=> History()));
              },
            ),
            ListTile(
              leading: Image.network('https://img.icons8.com/color/2x/in-app-messaging.png', width: 35, height: 35),
              // leading: Icon(Icons.login_outlined, color: Color(0xFF2271b1)),
              title: Text('Log Out'),
              onTap: (){
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    title: Center(child: Text("Alert!", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold))),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 52.0),
                      child: Text("Are you sure?", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400)),
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                           crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 90,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                  // auth.signOut();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneSignIn()));
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(50),
                                  primary: Colors.pink,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  // side: BorderSide(color: Colors.black),
                                  // elevation: 9.0,
                                ),
                                child: Text("Yes", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                              ),
                            ),
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
                                child: Text("No", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

    );
  }
}

