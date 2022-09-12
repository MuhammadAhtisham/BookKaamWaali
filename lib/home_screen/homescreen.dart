import 'package:bookkaamwaali/Design/BottomBar_Design.dart';
import 'package:bookkaamwaali/Design/SideBar_Drawer_Design.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:bookkaamwaali/register_login_screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sidebarx/sidebarx.dart';



//SQL DB - we have to run query to run CRUD operation. it is cheap but slower than than no sql db
// No SQL DB - also known as realtime database. More efficient but costly. eg: Mongo DB, Firebase Realtime DB, CloudStore
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  ///Common  class variable
  Common obj_common = Common();
  ///for sidebarX
  // final _controller = SidebarXController(selectedIndex: 0, extended: true);
  // final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      // drawer: SidebarXExampleApp(),
      // key: _key,
      // drawer: ExampleSidebarX(controller: _controller),
      // appBar: isSmallScreen
      //     ? AppBar(
      //       backgroundColor: canvasColor,
      //       title: Text("Home"),
      //       leading: IconButton(
      //         onPressed: () {
      //           _controller.setExtended(true);
      //           _key.currentState?.openDrawer();
      //         },
      //         icon: const Icon(Icons.menu),
      //       ),
      //     )
      //     : null,
      body:SafeArea(
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
                Container(
                  margin: EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
                  child: Column(
                    children: [
                      ///Location and logo
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  // margin: EdgeInsets.only(top: 15.0),
                                  ///Current Location
                                  Container(
                                    child: Text('Current Location',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                  ),
                                  ///Location
                                  Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        WidgetSpan(
                                            child: Icon(Icons.add_location, color: Colors.red, size: 23,)),
                                        TextSpan(text: 'Surakarta, INA'),

                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 23.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ///Logo
                            Container(
                              width: 55,
                              height: 50,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                elevation: 7.0,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 8, top: 8),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.deepOrange,
                                        size: 30,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ],

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ///Search bar
                      Container(
                        margin: EdgeInsets.only(top: 50.0, left: 10, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search_rounded,
                                color: Colors.deepOrange),
                            border: OutlineInputBorder(),
                            hintText: 'Search for event',
                          ),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ///Posts
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        height: 700,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          ///index always start from 0
                          itemBuilder: (BuildContext context, index){
                            return Stack(
                              children: [
                                /// Card Widget
                                Container(
                                  width: 350.0,
                                  height: 400.0,
                                  // margin: EdgeInsets.only(left: 10.0),
                                  child: Card(
                                    color: Colors.orange,
                                    // elevation: 12.0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(30.0),
                                      ),
                                    ),
                                    child:Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 35.0, top: 50),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text('OB\nJune',
                                                  style: TextStyle(
                                                    fontSize: 25.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),),
                                              ),
                                              SizedBox(height: 40),
                                              Container(
                                                child: Text('Surakarta\nClean City\nTogether',
                                                  style: TextStyle(
                                                    fontSize: 25.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),),
                                              ),
                                              SizedBox(height: 70),
                                              Text.rich(
                                                TextSpan(
                                                  children: <InlineSpan>[
                                                    WidgetSpan(
                                                        child: Icon(Icons.add_location, color: Colors.red, size: 23,)),
                                                    TextSpan(text: 'Surakarta, INA'),

                                                  ],
                                                ),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ),
                                        Container(
                                          width: 150,
                                          height: 400.0,
                                          // color: Colors.green,
                                          child:Image.asset('assets/images/person3.png',
                                            width: 70,
                                            height: 1.0,),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
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
       bottomNavigationBar: BottomBar(),
    );
  }
}
