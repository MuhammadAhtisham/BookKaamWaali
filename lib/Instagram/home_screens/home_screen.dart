import 'dart:math';
import 'package:bookkaamwaali/Design/BottomBar_Design.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:gradient_borders/gradient_borders.dart';



class InstagramHomeScreen extends StatelessWidget {
  const InstagramHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: HomeScreenSTF(),
    );
  }
}

class HomeScreenSTF extends StatefulWidget {
  const HomeScreenSTF({Key? key}) : super(key: key);

  @override
  State<HomeScreenSTF> createState() => _HomeScreenSTFState();
}

class _HomeScreenSTFState extends State<HomeScreenSTF> {

  late double width;
  late double height;

  List<String> productImageList=[
    'assets/images/girl1.png',
    'assets/images/girl2.png',
    'assets/images/girl3.jpg',
    'assets/images/girl4.jpg',
    'assets/images/girl5.jpg',
  ];

  List<String> productNameList=[
    'Suzena',
    'Zara',
    'Sidra',
    'NOOR',
    'Musfirrah'
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return
      Scaffold(
         backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                /// Heading
                Container(
                  //  margin: EdgeInsets.only(top: height*0.01),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///insta logo
                      Container(
                        child: Image.asset('assets/images/instagram.logo.jpg'),
                        width: 150,
                        height: 50,

                        // child: Text(
                        //   style: GoogleFonts.sansitaSwashed(
                        //     textStyle: Theme.of(context).textTheme.displayMedium,
                        //     color: Colors.white,
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.bold
                        //   ),
                        //   'instagram',
                        //   //  style:
                        //   // TextStyle(
                        //   //
                        //   //     fontWeight: FontWeight.w900,
                        //   //     fontStyle: FontStyle.italic,
                        //   //     fontSize: 25,
                        //   //     color: Colors.white,
                        //   // ),
                        // ),
                      ),
                      /// arrow icon
                      Container(
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      /// add icon
                      Container(
                        margin: EdgeInsets.only(left: 80,top: 5),
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.add_comment_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      /// favorite icon
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      /// chat icon
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        // child: IconButton(
                        //   onPressed: (){},
                        //   // icon: Icon(new Image.asset("assets/img/logo.png"),
                        //   //   // Icons.messenger_rounded,
                        //   //   // color: Colors.white,
                        //   // ),
                        // ),
                        child: ImageIcon(
                          AssetImage("assets/images/messenger icon.png"),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Stories Portion
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  // margin: EdgeInsets.only(top: height*0.01),
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Stack(
                                children: [
                                  new Container(
                                      width: width*0.2,
                                      height: height*0.13,
                                      margin: EdgeInsets.only(left: width*0.03),
                                      decoration: new BoxDecoration(
                                        border: const GradientBoxBorder(
                                          gradient: LinearGradient(colors: [Colors.yellow, Colors.red,Colors.pink]),
                                        ),
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          image: new ExactAssetImage(
                                              'assets/images/girl6.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  new Container(
                                    width: width*0.055,
                                    height: height*0.035,
                                    margin: EdgeInsets.only(left: width*0.18,top: height*0.07),
                                    child: Card(
                                      elevation: 9.0,
                                      color: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50.0)
                                      ),
                                      child: Icon(Icons.add,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /// story text
                            Container(
                              margin: EdgeInsets.only(left: width*0.02),
                              child: Text(
                                'Your Story',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: height*0.15,
                        width: width*0.701,
                        // margin: EdgeInsets.only(top: height*0.01),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:  productImageList.length,
                            itemBuilder: (BuildContext context, index){
                              return Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          new Container(
                                              width: width*0.18,
                                              height: height*0.12,
                                              margin: EdgeInsets.only(left: width*0.03),
                                              decoration: new BoxDecoration(
                                                border: const GradientBoxBorder(
                                                  gradient: LinearGradient(colors: [Colors.yellow, Colors.red,Colors.pink]),
                                                ),
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                  image: new ExactAssetImage(
                                                    productImageList[index],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(top: height*0.001, left: width*0.05),
                                            child: Text(
                                              productNameList[index],
                                              style: TextStyle(
                                                  color: Colors.white.withOpacity(0.8),
                                                  fontSize: 12
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),

                    ],
                  ),
                ),

                /// People Post
                Container(
                  height: height*0.6,
                  width: width,
                  //  margin: EdgeInsets.only(top: height*0.01),
                  child: ListView.builder(itemBuilder: (BuildContext context, index){
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            child: Card(
                              elevation: 9.0,
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        /// profile image
                                        new Container(
                                            width: width*0.12,
                                            height: height*0.06,
                                            margin: EdgeInsets.only(left: width*0.03),
                                            decoration: new BoxDecoration(
                                              border: const GradientBoxBorder(
                                                gradient: LinearGradient(colors: [Colors.yellow, Colors.red,Colors.pink]),
                                              ),
                                              // border: Border.all(color: Colors.pinkAccent),
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                image: new ExactAssetImage(
                                                    'assets/images/girl1.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                        /// post name container
                                        Container(
                                          margin: EdgeInsets.only(left: width*0.02),
                                          child: Text(
                                            'Suzena',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                        /// more icon
                                        Container(
                                            margin: EdgeInsets.only(left: width*0.5),
                                            child: IconButton(onPressed: (){},
                                              icon: Icon(Icons.more_horiz,
                                                  size: 19,
                                                  color: Colors.white
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  /// post image
                                  SizedBox(height: 10,),
                                  /// post image container
                                  Container(

                                    child: Image.asset(
                                      'assets/images/life-quotes-happy.jpg',

                                    ),
                                  ),
                                  /// icons row container
                                  Container(
                                    child: Row(
                                      children: [
                                        ///favourite icon
                                        Container(
                                          child: IconButton(onPressed: (){}, icon: Icon(
                                            Icons.favorite_outline_sharp,
                                            color: Colors.white,
                                          )),
                                        ),
                                        /// chat icon
                                        Container(
                                          child: IconButton(onPressed: (){}, icon: Icon(
                                            Icons.chat_bubble_outline,
                                            color: Colors.white,
                                          )),
                                        ),
                                        /// Arrow icon container
                                        Container(
                                          child: Transform.rotate(
                                            angle:-pi / 4,
                                            child: IconButton(onPressed: (){}, icon: Icon(
                                              Icons.send_outlined,
                                              color: Colors.white,
                                            )),
                                          ),
                                        ),
                                        /// book mark icon
                                        Container(
                                          margin: EdgeInsets.only(left: width*0.44),
                                          child: IconButton(onPressed: (){}, icon: Icon(
                                            Icons.bookmark_border,
                                            color: Colors.white,
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /// likes text container
                                  Container(
                                    margin: const EdgeInsets.only(right: 90),
                                    child: Text(
                                      'Liked by syedareeba50 and 790,947329 0ther',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,

                                      ),
                                    ),
                                  ),
                                  /// name container
                                  Container(
                                    margin: EdgeInsets.only(top: height*0.01),
                                    child: Row(
                                      children: [
                                        /// view text container
                                        Container(
                                          margin: EdgeInsets.only(left: width*0.036),
                                          child: Text(
                                            'Suzena',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,

                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   margin: EdgeInsets.only(left: width*0.02),
                                        //   child: Icon(Icons.star_border_outlined,
                                        //     color: Colors.white,
                                        //     size: 15,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: width*0.034),
                                          child: Text(
                                            'View all 20,4632 comments',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /// time text container
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: height*0.01,left: width*0.034),
                                          child: Text(
                                            '1 hour ago',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  ),
                ),



              ],
            ),
          ),

        ),
        bottomNavigationBar: BottomBar(),
      );

  }
}
