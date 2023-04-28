import 'package:bookkaamwaali/ChatApp/ChatApp_HomeScreen.dart';
import 'package:bookkaamwaali/register_login_screen/phone_signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CheckUserScreen extends StatelessWidget {
  const CheckUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if(auth.currentUser!=null)
      {
        return ChatAppHome();
      }
    else{
      return PhoneSignIn();
    }
  }
}

