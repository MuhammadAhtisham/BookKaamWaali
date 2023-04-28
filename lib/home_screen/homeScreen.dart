import 'package:bookkaamwaali/home_screen/drawer.dart';
import 'package:bookkaamwaali/home_screen/profilePage.dart';
import 'package:bookkaamwaali/home_screen/servicesPages/babysitter_MasseusePage.dart';
import 'package:bookkaamwaali/home_screen/servicesPages/cleanPage.dart';
import 'package:bookkaamwaali/home_screen/servicesPages/cook__Clean_Gardener_BabySitterrPage_Masseuse.dart';
import 'package:bookkaamwaali/home_screen/servicesPages/driverPage.dart';
import 'package:bookkaamwaali/home_screen/servicesPages/elderlyCarePage.dart';
import 'package:bookkaamwaali/home_screen/servicesPages/marriedCouplePage.dart';
import 'package:bookkaamwaali/home_screen/servicesPages/wash.dart';
import 'package:bookkaamwaali/models/service.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  List<Service> services = [
    Service('Couple', 'https://img.icons8.com/color/512/user-group-man-woman.png'),
    Service('Driver', 'https://img.icons8.com/color/2x/taxi.png'),
    Service('Day Care', 'https://img.icons8.com/color/2x/looking-after.png'),
    Service('BabySitter', 'https://img.icons8.com/color/2x/woman-with-baby.png'),
    Service('Masseuse', 'https://img.icons8.com/color/2x/baby-skin-type-1.png'),
    Service('Gardener', 'https://img.icons8.com/color/2x/farmer-male.png'),
  ];
  List<dynamic> workers = [
    ['Zara Asif', 'Cook', 'https://img.icons8.com/color/512/plumber.png', 4.8],
    ['Ahtisham', 'Cleaner', 'https://img.icons8.com/color/512/housekeeper-male.png', 4.6],
    ['Ibrahim', 'Driver', 'https://img.icons8.com/color/2x/driver.png', 4.4]
  ];

  String getGreeting() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Hello, Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Hello, Good Afternoon';
    } else {
      return 'Hello, Good Evening';
    }
  }

  final ref = FirebaseDatabase.instance.ref().child("Users");
  final userAuth =  FirebaseAuth.instance;
  late int selectedIndex = 0;
  ///get Data function
  Future<dynamic> getData()async{
    final snapshot = await ref.child(FirebaseAuth.instance.currentUser!.uid).get();
    if(snapshot.exists){
      print(snapshot.value);
    }else{
      print('No Data Found');
    }
    return snapshot.value;
  }


  Widget build(BuildContext context) {
    final _getData = getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('BookaamWaali', style: TextStyle(color: Colors.black),),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: Colors.grey.shade700, size: 30,),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.grey.shade700, size: 30,),
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(size:30,Icons.menu, color:Colors.blueAccent ,),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: SideDrawer(pageNumber: 0),
      body:SingleChildScrollView(
          child: Column(
              children: [
                /// greeting text and profile avatar
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            getGreeting(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 6),
                          FutureBuilder(
                              future: _getData,
                              builder:(builder ,  AsyncSnapshot<dynamic> snapshot){
                                if(!snapshot.hasData){
                                  // return Center(child: Text(""));
                                  return Center(child: CircularProgressIndicator(),);

                                }else{
                                  Map <dynamic,dynamic> map = snapshot.data as Map<dynamic,dynamic>;
                                  String name= map['name'];
                                  // String lname= map['Last Name'];
                                  // String email= map['Email'];
                                  // String password= map['Password'];
                                  return  Container(
                                     // alignment: Alignment.topLeft,
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }
                              }
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile_Page_Edit()));
                        },
                        child: CircleAvatar(
                          backgroundColor:Colors.blueAccent,
                          radius: 30,
                          child: Image.network('https://img.icons8.com/color/512/circled-user-male-skin-type-1-2--v1.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                /// divider
                Padding(padding: EdgeInsets.only(left: 20.0, top: 7.0, right: 10.0),
                  child:Divider(),
                ),
                ///most popular
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Most Popular', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                ),
                ///main services
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Clean
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CleaningPage(service: "Clean")));
                        },
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Color(0xffdfdeff),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                width: 60,
                                height:60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('https://img.icons8.com/color/2x/home.png'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Text("Clean Home", style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ///Wash
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> WashPage(service: "Wash", allServices: "Wash", additionalPrice: 0)));

                        },
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Color(0xffdfdeff),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                width: 60,
                                height:60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('https://img.icons8.com/color/2x/clothes-in-laundry.png'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Text("Laundry", style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ///Cook
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Cook__CleanGardener_BabySitter_MasseusePage(service: "Cook", allServices: "Cook", additionalPrice: 0)));

                        },
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            color: Color(0xffdfdeff),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                width: 60,
                                height:60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('https://img.icons8.com/color/2x/kitchen.png'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Text("Cooking", style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 15),
                ///recent
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      TextButton(
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> Select_Employee()));
                          },
                          child: Text('View all',)
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(0, 4),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network('https://img.icons8.com/color/512/housekeeper-male.png', width: 70,)
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ahtisham ul hassan", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text("Cleaner", style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 18),),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Center(child: Text('View Profile', style: TextStyle(color: Colors.white, fontSize: 18),)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      TextButton(
                          onPressed: () {},
                          child: Text('View all',)
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 270,
                  width: double.infinity,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: services.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  serviceContainer(services[index].imageURL, services[index].name, index);
                      }
                  ),
                ),
                 SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Top Rated', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      TextButton(
                          onPressed: () {},
                          child: Text('View all',)
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: workers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return workerContainer(workers[index][0], workers[index][1], workers[index][2], workers[index][3]);
                      }
                  ),
                ),
                SizedBox(height: 50,),
              ]
          )
      ),
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        selectedIndex=index;
        if (selectedIndex == index) {
          if(name=="Gardener")
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Cook__CleanGardener_BabySitter_MasseusePage(service: "Gardener", allServices: "Gardener", additionalPrice: 0)));
          if (name == "BabySitter")
            Navigator.push(context, MaterialPageRoute(builder: (context) => BabySitter_MasseusePage(service: "BabySitter", additionalPrice: 0)));
          if(name=="Masseuse")
            Navigator.push(context, MaterialPageRoute(builder: (context)=> BabySitter_MasseusePage(service: "Masseuse", additionalPrice: 0)));
          if(name=="Day Care")
           Navigator.push(context, MaterialPageRoute(builder: (context)=> ElrderlyCarePage(service: "Elderly Care", additionalPrice: 0)));
          if(name=="Driver")
            Navigator.push(context, MaterialPageRoute(builder: (context)=> DriverPage(service: "Driver", additionalPrice: 0)));
          if(name=="Couple")
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MarriedCouplePage(service: "Married Couple", additionalPrice: 0)));


        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(
            color: Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 45),
              SizedBox(height: 20,),
              Center(child: Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),))
            ]
        ),
      ),
    );
  }

  workerContainer(String name, String job, String image, double rating) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Container(
          margin: EdgeInsets.only(right: 20),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(image)
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Text(job, style: TextStyle(fontSize: 15),)
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(rating.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Icon(Icons.star, color: Colors.orange, size: 20,)
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}