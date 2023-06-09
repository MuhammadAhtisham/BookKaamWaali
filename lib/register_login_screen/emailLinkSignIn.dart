import 'package:bookkaamwaali/register_login_screen/emailLinkSignIn_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: GetBuilder<SignInController>(
        init: SignInController(),
        builder: (controller) {
          return Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/images/ns-logo-dark-f.png',
                        width: 200,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      focusNode: controller.focusNode,
                      controller: controller.emailTEC,
                      style: const TextStyle(color: Colors.blueAccent),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'e.g ajay.kumar@nonstopio.com',
                        labelStyle: const TextStyle(color: Colors.purple),
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurpleAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.sendEmailLink,
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}