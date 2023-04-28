

import 'package:bookkaamwaali/Design/InternectConnectivity_Design.dart';
import 'package:bookkaamwaali/Notifications/inApp_Notifications.dart';
import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'package:bookkaamwaali/home_screen/servicesPages/feedBackPage.dart';
import 'package:bookkaamwaali/register_login_screen/needJob.dart';

import 'package:bookkaamwaali/register_login_screen/otpScreen.dart';
import 'package:bookkaamwaali/register_login_screen/registerInfo.dart';
import 'package:bookkaamwaali/register_login_screen/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:bookkaamwaali/splash_screen/splashScreen.dart';
import 'package:bookkaamwaali/realTime_Database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bookkaamwaali/data/utils/app_loader.dart';
import 'package:get/get.dart';
// import 'data/services/auth/auth_service.dart';
// import 'firebase_options.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppLoader.init();
  // Get.put(AuthService());

   // WidgetsFlutterBinding.ensureInitialized();
   // await Firebase.initializeApp();


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
  runApp(kaamWaali());
}

class kaamWaali extends StatelessWidget  with WidgetsBindingObserver{
  const kaamWaali({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return OverlaySupport.global(
      child: FirebasePhoneAuthProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          builder: EasyLoading.init(),
        ),
      ),
    );

  }
}


