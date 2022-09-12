import 'dart:async';
import 'package:bookkaamwaali/Design/BottomBar_Design.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Design/SideBar_Drawer_Design.dart';
import 'package:firebase_auth/firebase_auth.dart';
class User_List extends StatefulWidget {
  const User_List({Key? key}) : super(key: key);

  @override
  State<User_List> createState() => _User_ListState();
}

class _User_ListState extends State<User_List> {
  late String status = "waiting..";
  late StreamSubscription InternetSubscription;
  bool hasInternet = false;

  ///get Data function
  getData()async{
    final snapshot = await ref.child('Edit Profile/BFaLm6BWtrhhzbC1pZncApdvBAP2').get();

    if(snapshot.exists){
      print(snapshot.value);
    }else{
      print('No Data Found');
    }
    return snapshot.value;
  }
  Common obj_common = Common();
  @override
  void initState()
  {
    super.initState();
    InternetSubscription = InternetConnectionChecker().onStatusChange.listen((status) {
       final hasInternet = status == InternetConnectionStatus.connected;
       setState(() => this.hasInternet = hasInternet);

    });
  }

  void disposed(){
    InternetSubscription.cancel();
    super.dispose();
  }

  final ref = FirebaseDatabase.instance.ref();
  FirebaseAuth userAuth =  FirebaseAuth.instance;


  final _controller = SidebarXController(selectedIndex: 1, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      key: _key,
      drawer: ExampleSidebarX(controller: _controller),
      // appBar: AppBar(
      //   title: Text('Users'),
      //   backgroundColor: Color(0xFF2E2E48),
      // ),
      appBar: isSmallScreen
          ? AppBar(
            backgroundColor: canvasColor,
            title: Text("Home"),
            leading: IconButton(
              onPressed: () {
                _controller.setExtended(true);
                _key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          )
          : null,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async{

                  final snapshot = await ref.child('Products/-N9ByMvLDnJmIYALa5zt').get();
                  if (snapshot.exists) {
                    print(snapshot.value);
                  } else {
                    print('No data available.');
                  }
                },
                child: Text("Get Data",
                style: TextStyle(
                  fontSize: 34,
                ),),
              ),
              Text('Welcome'),
              FutureBuilder(
                  future: getData(),
                  builder:(builder , snapshot){
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(),);

                    }else{
                      Map <dynamic,dynamic> map = snapshot.data as Map<dynamic,dynamic>;
                      String fname= map['First Name'];
                      String lname= map['Last Name'];
                      String email= map['Email'];
                      String password= map['Password'];
                      return Column(
                        children: [
                          obj_common.headingtextWidget('First Name ${fname}'),
                          obj_common.headingtextWidget('Last Name ${lname}'),
                          obj_common.headingtextWidget('Email ${email}'),
                          obj_common.headingtextWidget('Gender ${password}'),
                        ],
                      );
                    }
                  }
              ),
              // Container(
              //   child: ElevatedButton(
              //     onPressed: () async{
              //       hasInternet = await InternetConnectionChecker().hasConnection;
              //
              //       final color = hasInternet ? Colors.green : Colors.red;
              //       final text = hasInternet ? 'Internet' : 'No Internet';
              //       showSimpleNotification(
              //           Text('$text',
              //           style: TextStyle(
              //               color: Colors.white,
              //             fontSize: 40,
              //            ),
              //           ),
              //         background: color,
              //       );
              //     },
              //     child: Text("Check Internet",
              //       style: TextStyle(
              //         fontSize: 34,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    //  bottomNavigationBar: BottomBar(),
    );
  }
}

///listview only scrolls data and you can set direction
///listviewBuilder is used when you also want to show data dynamically
///$ is used to concatenate