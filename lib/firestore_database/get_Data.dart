import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GetDataFromFirebase extends StatefulWidget {
  const GetDataFromFirebase({Key? key}) : super(key: key);

  @override
  State<GetDataFromFirebase> createState() => _GetDataFromFirebaseState();
}

class _GetDataFromFirebaseState extends State<GetDataFromFirebase> {
  /// step -1
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  /// step -2 => Get Data Function
  getData()async{
    final snapshot = await ref.child('Edit Profile').get();

    if(snapshot.exists){
      print(snapshot.value);
    }else{
      print('No Data Found');
    }
    return snapshot.value;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Text('Product Screen',style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
              ///Step-3=> Future Builder => Show Data
              FutureBuilder(
                future: getData(),
                builder: (builder, snapshot){
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }else{

                    Map<dynamic, dynamic> map = snapshot.data as Map<dynamic,dynamic>;

                    List<String> fname=[];// john, ali
                    List<String> lname=[]; //21,25
                    List<String> email =[]; // lake,lahore
                    List<String> password =[];
                    int count =0;  // 1+1=2

                    map.forEach((key, value) {
                      fname.add(value['First Name']);
                      lname.add(value['Last Name']);
                      email.add(value['Email']);
                      password.add(value['Password']);
                      count++;
                    });
                    return Container(
                      height: 600,
                      width: 600,
                      child: ListView.builder(
                          itemCount: count,
                          itemBuilder: (builder, index){
                            return Card(
                              child: Column(
                                children: [
                                  Text('First Name : ${fname[index]}'),
                                  Text('Last Name : ${lname[index]}'),
                                  Text('Email : ${email[index]}'),
                                  Text('Password : ${password[index]}'),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}