import 'package:bookkaamwaali/Utilis/colorScheme.dart';
import 'package:bookkaamwaali/register_login_screen/welcome_page.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:rive/rive.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var SharedPrefrences;
  final prefs = await SharedPrefrences.getInstance();
  final welcome = prefs.getbool('welcome') ?? false;
}
// class scroll_screen extends StatelessWidget {
//   const scroll_screen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'ubuntu',
//       ),
//     );
//   }
// }
class ScrollScreen extends StatefulWidget {
  const ScrollScreen({Key? key}) : super(key: key);

  @override
  State<ScrollScreen> createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  ///responsive start
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
  ///responsive end
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Container(
          //padding: EdgeInsets.only(bottom: 80.0),
          child:PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (index){
              setState(()=> isLastPage = index ==2);
            },
            children: [
              //first page
              Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Clean",
                        style: TextStyle(
                            fontSize: 40, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                        width:5,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Home',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                          TyperAnimatedText('Building',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                          TyperAnimatedText('Apartment',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                        //onTap: onTap,
                        isRepeatingAnimation: true,
                        totalRepeatCount: 20,
                      ),
                    ],
                  ),
                  Text(
                    "Clean Life",
                    style: TextStyle(
                        fontSize: 30, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
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
                    height: 50,
                  ),
                  // RiveAnimation.asset(
                  //   'assets/images/p1.png',
                  // ),
                  Container(
                    child: Image(
                      width: 450,
                      height:450,
                      image: AssetImage('assets/images/s1.png'),

                    ),
                  ),

                ],
              ),
              //second page
              Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Clean",
                        style: TextStyle(
                            fontSize: 40, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                        width:5,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Home',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                          TyperAnimatedText('Building',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                          TyperAnimatedText('Apartment',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                        //onTap: onTap,
                        isRepeatingAnimation: true,
                        totalRepeatCount: 20,
                      ),
                    ],
                  ),
                  Text(
                    "Clean Life",
                    style: TextStyle(
                        fontSize: 30, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
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
                    height: 50,
                  ),
                  Container(
                    child: Image(
                      width: 400,
                      height:400,
                      image: AssetImage('assets/images/w1.jpg'),

                    ),
                  ),

                ],
              ),
              //third page
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Clean",
                        style: TextStyle(
                            fontSize: 40, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                        width:5,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Home',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                          TyperAnimatedText('Building',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                          TyperAnimatedText('Apartment',
                            textStyle: TextStyle(
                              fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                        //onTap: onTap,
                        isRepeatingAnimation: true,
                        totalRepeatCount: 20,
                      ),
                    ],
                  ),
                  Text(
                    "Clean Life",
                    style: TextStyle(
                        fontSize: 30, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
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
                    height: 10,
                  ),
                  Container(
                    child: Image(
                      width: 200,
                      height:200,
                      image: AssetImage('assets/images/kit1.png'),

                    ),
                  ),

                ],
              ),

            ],
          ),

        ),
      ),
      bottomSheet: isLastPage ? TextButton(
        style:TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          // backgroundColor: white,
          alignment: Alignment.bottomCenter,
        ),
        onPressed: () async{
          var SharedPrefrences;
          final prefs = await SharedPrefrences.getInstance();
          prefs.setBool('welcome',true);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>WelcomePage()),
          );

        },
        child:Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              //image cpntainer
              Container(),
              /// gradient
              Container(
                height: 770,
                width: double.infinity,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [
                  //       Colors.white,
                  //       Colors.white,
                  //       Colors.blueAccent,
                  //     ],
                  // ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///text Container
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Clean",
                              style: TextStyle(
                                  fontSize: 40, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                              width:5,
                            ),
                            AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText('Home',
                                  textStyle: TextStyle(
                                    fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                                  ),
                                ),
                                TyperAnimatedText('Building',
                                  textStyle: TextStyle(
                                    fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                                  ),
                                ),
                                TyperAnimatedText('Apartment',
                                  textStyle: TextStyle(
                                    fontSize: 35, color: Colors.pink.shade300, fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                              //onTap: onTap,
                              isRepeatingAnimation: true,
                              totalRepeatCount: 20,
                            ),
                          ],
                        ),
                        Text(
                          "Clean Life",
                          style: TextStyle(
                              fontSize: 30, color: Colors.pink.shade300, fontWeight: FontWeight.w900),
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
                      ],
                    ),
                    /// end text scroll button in scroll screen
                    ///button
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      child: Image(
                        width: 400,
                        height:400,
                        image: AssetImage('assets/images/p1.png'),

                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 250,
                      height:60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: pink,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomePage()));
                          },
                          child: Text('GET STARTED',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ),

            ],
          ),
        ),

      ): Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomePage()));
              } ,
              //()=> controller.jumpTo(2)
              child: Text('SKIP'),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count:3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.blueAccent,
                  activeDotColor: pink,

                ),
                onDotClicked: (index)=>controller.animateToPage(
                    index,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn),
              ),
            ),
            TextButton(
              onPressed: ()=> controller.nextPage(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeInOut),
              child: Text('NEXT'),
            ),
          ],
        ),

      ),

    );
  }
}
