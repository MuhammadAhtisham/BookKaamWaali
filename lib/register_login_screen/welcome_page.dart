import 'package:bookkaamwaali/register_login_screen/needJob.dart';
import 'package:bookkaamwaali/register_login_screen/phone_signIn.dart';
import 'package:flutter/material.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  double displayHeight(BuildContext context) {
    debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.white,
              Colors.blueAccent,
            ]
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Center(
          child: Column(
            children: [
              //Text
              SizedBox(
                height: 150,
              ),
              Text(
                "Clean Home\nClean Life",
                style: TextStyle(
                    fontSize: 40, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Book Cleans At The Comfort \nOf Your Home",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.pink.shade300,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 280,
              ),

              //Buttons
              Container(
                height: 150,
                width:300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //First button
                    Container(

                      child: OutlinedButton(
                          child: Text('LOGIN'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: Colors.pink),
                            primary: Colors.pink,
                            minimumSize: Size(160.0, 70.0),
                            textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhoneSignIn()));
                          }
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 130,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF8A2387),
                                Color(0xffdc4f89),
                                Color(0xFF8A2387),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20.0, // soften the shadow
                                spreadRadius: 2.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              ),
                            ],
                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(5.0),
                            child: InkWell
                              (
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NeedJob()));
                              },
                              child: Text('NEED A JOB',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'Don\'t have account?. ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell
                    (
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneSignIn()));
                    },
                    child: Text('Register',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}