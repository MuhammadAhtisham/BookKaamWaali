import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RealTimeData1 extends StatelessWidget {
  const RealTimeData1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: RealTimeData2(),
    );
  }
}

class RealTimeData2 extends StatefulWidget {
  const RealTimeData2({Key? key}) : super(key: key);


  @override
  State<RealTimeData2> createState() => _RealTimeData2State();
}

class _RealTimeData2State extends State<RealTimeData2> {

  DatabaseReference database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () async{
            database.child("Users").child("user1").child("CIT").set("UOL");
            // database.child("Products").child("p1").child("name").set("Hair Serum");
            // database.child("Products").child("p1").child("price").set("\$45");
            // database.child("Products").child("p1").child("description").set("abcd");
            // database.child("Products").child("p2").child("name").set("Hair Spray");
            // database.child("Products").child("p3").child("name").set("Hair Cream");
            // database.child("Products").child("p4").child("name").set("Hair Color");

            ///this format is called json format
            // await database.child("Products").child("p6").set({
            //   "name" : "Perfume",
            //   "price" : "46.9",
            //   "description" : "Perfume",
            //   "variants": {
            //     "S1" : "Small",
            //     "S2" : "Medium",
            //     "S3" : "Large",
            //   },
            // });
            // await database.child("Products").child("p6").update({
            //   "price" : "46.9",
            // });
            // await database.child("Products").child("p6").child("variants").update({
            //    "S1" : "small",
            //  });


            ///push sets name automatically
            // await database.child("Products").push().set({
            //   "name" : "Perfume",
            //   "price" : "46.9",
            //   "description" : "Perfume",
            //   "variants": {
            //     "S1" : "Small",
            //     "S2" : "Medium",
            //     "S3" : "Large",
            //   },
            // });
          },
          child: Text("Send  Data",
          style: TextStyle(
            fontSize: 20,
          ),),
        ),
      ),
    );
  }
}

//// take firest name from user, last name , email, age , gender