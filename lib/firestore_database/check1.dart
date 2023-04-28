import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class testFirebase extends StatefulWidget {
  const testFirebase({Key? key}) : super(key: key);

  @override
  State<testFirebase> createState() => _testFirebaseState();
}

class _testFirebaseState extends State<testFirebase> {
  DatabaseReference snapshot = FirebaseDatabase.instance.ref();
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  getData() async{
    final snapshot = await ref.child('user1').get();
    if(snapshot.exists){
      print(snapshot.exists);
    }else{
      print('No data found');
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController addressController = TextEditingController();


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    /// text edit profile
                    SizedBox(height: 25,),
                    Center(
                        child: Container(
                          child: Text('Edit Profile',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,

                            ),),
                        )
                    ),
                    /// textfield full name
                    SizedBox(height: 50,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_outline_outlined,
                                color: Colors.green,
                              ),
                              border: InputBorder.none,
                              hintText: 'First Name',

                            )),
                      ),
                    ),
                    /// textfield last name
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_outline_outlined,
                                color: Colors.green,
                              ),
                              border: InputBorder.none,
                              hintText: 'Last Name',

                            )),
                      ),
                    ),
                    /// textfield email
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.green,
                              ),
                              border: InputBorder.none,
                              hintText: 'Email Address',

                            )),
                      ),
                    ),
                    /// textfield gender
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                            controller: genderController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.transgender,
                                color: Colors.green,
                              ),
                              border: InputBorder.none,
                              hintText: 'Gender',

                            )),
                      ),
                    ),
                    /// textfield age
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                              border: InputBorder.none,
                              hintText: 'Address',

                            )),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(400, 60),
                            maximumSize: const Size(400, 60),
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: ()  async{


                            await snapshot.child("User").child(FirebaseAuth.instance.currentUser!.uid).set({
                              "fname": firstNameController.text,
                              "lname": lastNameController.text ,
                              "email": emailController.text,
                              "gender": genderController.text,
                              "address": addressController.text,

                            });

                          },
                          child: Text(
                            'Set data',
                            style: TextStyle(
                              fontSize: 18,

                            ),
                          )),
                    ),
                    /// get data
                    SizedBox(height: 20,),
                    Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(400, 60),
                            maximumSize: const Size(400, 60),
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          onPressed: ()  async{


                            final snapshot = await ref.child('User').get();
                            if(snapshot.exists){
                              print(snapshot.exists);

                            }else{
                              print('No data found');
                            };


                          },
                          ///user name displayed
                          child: Text(
                            'Get Data',
                            style: TextStyle(
                              fontSize: 18,

                            ),
                          )),
                    ),
                    Text('Welcome'),
                    FutureBuilder(
                        future: getData(),
                        builder:(builder , snapshot){
                          if(!snapshot.hasData){
                            return Center(child: CircularProgressIndicator(),);

                          }else{
                            Map <dynamic,dynamic> map = snapshot.data as Map<dynamic,dynamic>;
                            String fname= map['First name'];
                            String lname= map['Last name'];
                            String email= map['Email Address'];
                            String gender= map['Gender'];
                            String address= map['Address'];
                            return Column(
                              children: [
                                Text(fname),
                                Text(lname),
                                Text(email),
                                Text(gender),
                                Text(address),


                              ],
                            );
                          }

                        }
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///when we manipulate product info then we use push id.