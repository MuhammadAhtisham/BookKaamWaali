import 'package:bookkaamwaali/Design/InputDeco_design.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:bookkaamwaali/register_login_screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final formkey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  ///Common class variable
  Common obj_common = Common();

  void disposed() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: SafeArea(
        child: SingleChildScrollView(

           child: Padding(
             padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                  },
                  child: obj_common.appBarContainer(),
                ),
                Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      obj_common.headingtextWidget('Forget Password'),
                      SizedBox(height: 20),
                      obj_common.subheadingtextWidget("Please enter your email address. You will\nrecieve a link to create a new password\n via email."),
                      SizedBox(height: 40),
                      SizedBox(

                        width:330,
                        height: 45,
                        child: TextFormField(
                          controller: emailController,
                          decoration:buildInputDecoration(Icons.email,"Your Email"),
                          cursorColor: Color(0xFF3E3E61),
                          style: obj_common.TextStyleWidget(),
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid Email' : null,
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width:330,
                        height: 45,
                        child: ElevatedButton(
                          style: obj_common.btnStyleWidget(),
                          child:obj_common.btntextWidget('Reset Password'),
                          onPressed: resetPassword,
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
           ),
        ),
      ),
    );
  }


  Future resetPassword() async{
    if(emailController.text.isNotEmpty)
    {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Password reset instructions have been sent to email!'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                    },
                  ),
                ],
              );
            });
        // Navigator.of(context).popUntil((route) => route.isFirst);

      }on FirebaseAuthException catch(e){
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
            new SnackBar(duration: new Duration(seconds: 4), content:
            new Row(
              children: <Widget>[
                new CircularProgressIndicator(),
                new Text("A network error has occurred."),
              ],
            ),
            ));
        }
      }
    else{
      Fluttertoast.showToast(
          msg: "please enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}


