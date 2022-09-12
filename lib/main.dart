import 'package:bookkaamwaali/ChatApp/Check_User.dart';
import 'package:bookkaamwaali/Design/BottomBar_Design.dart';
import 'package:bookkaamwaali/Design/SideBar_Drawer_Design.dart';
import 'package:bookkaamwaali/Design/InternectConnectivity_Design.dart';
import 'package:bookkaamwaali/Notifications/inApp_Notifications.dart';
import 'package:bookkaamwaali/Profile/Profile.dart';
import 'package:bookkaamwaali/Profile/User_List.dart';
import 'package:bookkaamwaali/Profile/edit_Profile.dart';
import 'package:bookkaamwaali/Utilis/get_Data.dart';
import 'package:bookkaamwaali/check.dart';
import 'package:bookkaamwaali/register_login_screen/Login_options.dart';
import 'package:bookkaamwaali/register_login_screen/OTP_Code.dart';
import 'package:bookkaamwaali/register_login_screen/forgetpassword.dart';
import 'package:flutter/material.dart';
import 'package:bookkaamwaali/register_login_screen/registerscreen.dart';
import 'package:bookkaamwaali/register_login_screen/loginscreen.dart';
import 'package:bookkaamwaali/home_screen/homescreen.dart';
import 'package:bookkaamwaali/realTime_Database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'register_login_screen/PhoneNumber_Verification.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //initilization of Firebase app

  // other Firebase service initialization


  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    ///by default, your app logo will be set
    //   'resource://drawable/res_app_icon',
    null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget  with WidgetsBindingObserver{
  const MyApp({Key? key}) : super(key: key);
      MaterialColor generateMaterialColor(Color color) {
        return MaterialColor(color.value, {
          50: tintColor(color, 0.9),
          100: tintColor(color, 0.8),
          200: tintColor(color, 0.6),
          300: tintColor(color, 0.4),
          400: tintColor(color, 0.2),
          500: color,
          600: shadeColor(color, 0.1),
          700: shadeColor(color, 0.2),
          800: shadeColor(color, 0.3),
          900: shadeColor(color, 0.4),
        });
      }

      int tintValue(int value, double factor) =>
          max(0, min((value + ((255 - value) * factor)).round(), 255));

      Color tintColor(Color color, double factor) => Color.fromRGBO(
          tintValue(color.red, factor),
          tintValue(color.green, factor),
          tintValue(color.blue, factor),
          1);

      int shadeValue(int value, double factor) =>
          max(0, min(value - (value * factor).round(), 255));

      Color shadeColor(Color color, double factor) => Color.fromRGBO(
          shadeValue(color.red, factor),
          shadeValue(color.green, factor),
          shadeValue(color.blue, factor),
          1);
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {

    return OverlaySupport.global(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // fontFamily: 'SquarePeg',
          primarySwatch: generateMaterialColor(Palette.primary),
        ),
        home: const SplashScreen(),
      ),
    );

  }
}
class Palette {
  static const Color primary = Color(0xFF3E3E61);
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          body: SplashScreenView(
            navigateRoute: LoginScreen(),
            duration: 5000,
            imageSize: 130,
            imageSrc: "assets/images/logo.png",
            text: "Book Kaam Waali",
            textType: TextType.ColorizeAnimationText,
            textStyle: TextStyle(
              fontSize: 40.0,
            ),
            colors: [
              Color(0xFF40826D),
              Colors.black,
              Color(0xFF40826D),
              Colors.black,
              Color(0xFF40826D),
            ],
            backgroundColor: Colors.white,
          ),
        )
    );
  }
}