import 'package:bookkaamwaali/register_login_screen/PhoneNumber_Verification.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:bookkaamwaali/register_login_screen/loginscreen.dart';
import 'package:bookkaamwaali/register_login_screen/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
class LoginOptions extends StatefulWidget {
  const LoginOptions({Key? key}) : super(key: key);

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {

  Common obj_common = Common();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
          Column(
            children:<Widget> [
              ///logo
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 100),
                child: Image.asset("assets/images/logo.png",
                    height: 200
                ),
              ),
              SizedBox(height: 10),
              ///login with email
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                },
                    style: obj_common.btnStyleWidget(),
                    child: obj_common.btntextWidget("Log In")),
              ),

              SizedBox(height: 10),

              ///Sign up
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                },
                    style: obj_common.btnStyleWidget(),
                    child: obj_common.btntextWidget("Sign Up")),
              ),
              ///divider OR
              Row(children: [
                Expanded(
                  child: new Container(
                      // margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                        indent: 50,
                        endIndent: 10,
                      )),
                ),

                Text("OR"),
                Expanded(
                  child: new Container(
                      // margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                        indent: 10,
                        endIndent: 50,
                      )),
                ),
              ]),

              SizedBox(height: 10),

              Text("Login using social networks",
              style: TextStyle(
                fontSize: 10,
                color: Colors.black26,
                fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ///login with google
              SignInButton(
                Buttons.Google,
                onPressed: () {
                },
              ),

              SizedBox(height: 1),

              ///login with facebook
              SignInButton(
                Buttons.FacebookNew,
                onPressed: () {
                },
              ),
            ],
          ),
        ),
    );
  }
}
