import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'package:bookkaamwaali/splash_screen/scrollScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  //a function has only  one state then we use =>
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }
  //async function because we are going to use time
  void navigateToHome() async{
    await Future.delayed(Duration(milliseconds: 2000),(){
        if (FirebaseAuth.instance.currentUser != null) {
          print('User is currently signed in!');
          print(FirebaseAuth.instance.currentUser!.uid);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home_Page()));
        }
        else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ScrollScreen()));
          print('User is signed out!');
        }
      // FirebaseAuth.instance
      //     .authStateChanges()
      //     .listen((User? user) {
      //   if (user == null) {
      //     print('User is currently signed out!');
      //   } else {
      //     print('User is signed in!');
      //   }
      // });
      // FirebaseAuth.instance
      //     .idTokenChanges()
      //     .listen((User? user) {
      //   if (user == null) {
      //     print('User is currently signed out!');
      //   } else {
      //     print('User is signed in!');
      //   }
      // });
      });
    //pushReplacement because i am going end the splash screen

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple,
              Colors.purple,
              Colors.deepPurpleAccent,

            ]
        ),
      ),
      child: Scaffold(
          backgroundColor:Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  height: 330,
                  width: 330,
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: CircleAvatar(
                    radius: 17,
                    backgroundImage: AssetImage('assets/images/logo.png'),  ),
                ),
                //Image
                // Container(
                //   width: 300.0,
                //   height: 500.0,
                //   // color:Colors.red,
                //   child: Image.asset("assets/images/logo.png",width: 400, height: 400)
                // ),
                //For Space
                SizedBox(
                  width: 40.0,
                  height: 100.0,
                ),

                //Text
                // Container(
                //   child: Text(
                //     'BooKaamWaali',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 35.0,
                //     ),
                //   ),
                // ),
              ],
            ),
          )
      ),
    );
  }


}
