import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
class Profile_Page_Edit extends StatefulWidget {
  const Profile_Page_Edit({Key? key}) : super(key: key);

  @override
  State<Profile_Page_Edit> createState() => _Profile_Page_EditState();
}

class _Profile_Page_EditState extends State<Profile_Page_Edit> {
  @override

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref();
  final ref1 = FirebaseDatabase.instance.ref();
  FirebaseAuth userAuth =  FirebaseAuth.instance;
  ///get Data function
  getData()async{
    final snapshot = await ref.child('Users').child(userAuth.currentUser!.uid).get();

    if(snapshot.exists){
      print(snapshot.value);
    }else{
      print('No Data Found');
    }
    return snapshot.value;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.pink,
      //   elevation: 0,
      //   toolbarHeight: 95,
      //   leading: TextButton(
      //     child: Text("x", style: TextStyle(fontSize: 18.5,color: Colors.white),),
      //     onPressed: () {
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page()));
      //     },
      //   ),
      //   actions: [
      //     TextButton(
      //       child: Padding(
      //          padding: const EdgeInsets.only(top: 2, right: 2.0),
      //         child: Text("Done", style: TextStyle(fontSize: 18.5,color: Colors.white),),
      //       ),
      //       onPressed: () {
      //       },
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  // width: 20,
                   height: 60,
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {});
                          Navigator.of(context).pop();
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page()));
                          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes Cancelled')),
                        },
                        child: Text("Cancel", style: TextStyle(fontSize: 18.5,color: Colors.white, fontWeight: FontWeight.w500),),
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {

                            await ref1.child("Users").child(userAuth.currentUser!.uid).update({
                              "name": nameController.text.trim(),
                              "email": emailController.text.trim(),
                              "phoneNumber": phoneNumberController.text.trim(),
                              "address" : addressController.text.trim(),
                            });
                            setState(() {

                            });
                            Navigator.of(context).pop();
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Page()));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes Saved')),);
                          }
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen()));


                        },
                        child: Text("Done", style: TextStyle(fontSize: 18.5,color: Colors.white, fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Column(
                          children: [
                            Text(
                              "Edit Profile",
                              style: TextStyle(color:Colors.white,fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4,
                                            color: Theme.of(context).scaffoldBackgroundColor),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color: Colors.black.withOpacity(0.1),
                                              offset: Offset(0, 10))
                                        ],
                                        shape: BoxShape.circle,
                                        // image: DecorationImage(
                                        //     fit: BoxFit.cover,
                                        //     image: NetworkImage(
                                        //         'https://img.icons8.com/color/512/circled-user-male-skin-type-1-2--v1.png'
                                        //     ))
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor:Colors.blueAccent,
                                      radius: 30,
                                      child: Image.network('https://img.icons8.com/color/512/circled-user-male-skin-type-1-2--v1.png'),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 4,
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                          ),
                                          color: Colors.pink,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            FutureBuilder(
                                future: getData(),
                                builder:(builder , snapshot){
                                  if(!snapshot.hasData){
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 35.0),
                                          child: TextFormField(
                                            controller: nameController,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Required Field';
                                              }
                                              if (!validator.name(value)) {
                                                return 'Please enter full name and first letter in caps';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(bottom: 3),
                                                labelText: "Full Name",
                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                // hintText: placeholder,
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 35.0),
                                          child: TextFormField(
                                            controller: emailController,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Required Field';
                                              }
                                              if (!validator.email(value)) {
                                                return 'Please enter full name and first letter in caps';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(bottom: 3),
                                                labelText: "Email",
                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 35.0),
                                          child: TextFormField(
                                            enabled: false,
                                            controller: phoneNumberController,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Required Field';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(bottom: 3),
                                                labelText: "Phone Number",
                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 35.0),
                                          child: TextFormField(
                                            controller: addressController,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Required Field';
                                              }
                                              return null;
                                            },

                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(bottom: 3),
                                                labelText: "Location",
                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                // hintText: placeholder,
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //   children: [
                                        //     InkWell(
                                        //       onTap: (){
                                        //         setState(() {
                                        //
                                        //         });
                                        //         //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen()));
                                        //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes Cancelled')),
                                        //         );
                                        //
                                        //       },
                                        //       child: Container(
                                        //         width: 120,
                                        //         height: 50,
                                        //         padding: EdgeInsets.all(15),
                                        //         decoration: BoxDecoration(
                                        //             borderRadius: BorderRadius.circular(50),
                                        //             color: Colors.blue[800]
                                        //         ),
                                        //         child: Center(child: Text("Cancel", style: TextStyle(fontSize:15,color: Colors.white),)),
                                        //       ),
                                        //     ),
                                        //     InkWell(
                                        //       onTap: () async {
                                        //
                                        //         if (_formKey.currentState!.validate()) {
                                        //
                                        //           await ref1.child("Users").child(userAuth.currentUser!.uid).update({
                                        //             "name": nameController.text.trim(),
                                        //             "email": emailController.text.trim(),
                                        //             "phoneNumber": emailController.text.trim(),
                                        //             "address" : addressController.text.trim(),
                                        //           });
                                        //           setState(() {
                                        //
                                        //           });
                                        //         }
                                        //
                                        //         //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen()));
                                        //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes Saved')),);
                                        //
                                        //       },
                                        //       child: Container(
                                        //         width: 120,
                                        //         height: 50,
                                        //         padding: EdgeInsets.all(15),
                                        //         decoration: BoxDecoration(
                                        //             borderRadius: BorderRadius.circular(50),
                                        //             color: Colors.blue[800]
                                        //         ),
                                        //         child: Center(child: Text("Save", style: TextStyle(fontSize:15,color: Colors.white),)),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    );

                                  }else{
                                    Map <dynamic,dynamic> map = snapshot.data as Map<dynamic,dynamic>;
                                    String name= map['name'];
                                    String email= map['email'];
                                    String phoneNumber= map['phoneNumber'];
                                    String address= map['address'];
                                    nameController.text = name;style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,);
                                    emailController.text = email;style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,);
                                    phoneNumberController.text = phoneNumber;style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,);
                                    addressController.text = address;style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,);
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 35.0),
                                          child: TextFormField(
                                            controller: nameController,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Required Field';
                                              }
                                              if (!validator.name(value)) {
                                                return 'Please enter full name and first letter in caps';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(bottom: 3),
                                                labelText: "Full Name",
                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                // hintText: placeholder,
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 35.0),
                                          child: TextFormField(
                                            controller: emailController,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Required Field';
                                              }
                                              if (!validator.email(value)) {
                                                return 'Please enter full name and first letter in caps';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(bottom: 3),
                                                labelText: "Email",
                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 35.0),
                                          child: TextFormField(
                                             enabled: false,
                                            controller: phoneNumberController,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Required Field';
                                              }
                                              return null;
                                              },
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(bottom: 3),
                                                labelText: "Phone Number",
                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 35.0),
                                          child: TextFormField(
                                            controller: addressController,
                                            validator: (value){
                                              if (value == null || value.isEmpty) {
                                                return 'Required Field';
                                              }
                                              return null;
                                              },

                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(bottom: 3),
                                                labelText: "Location",
                                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                                // hintText: placeholder,
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //   children: [
                                        //     InkWell(
                                        //       onTap: (){
                                        //         setState(() {
                                        //
                                        //         });
                                        //         //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen()));
                                        //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes Cancelled')),
                                        //         );
                                        //
                                        //       },
                                        //       child: Container(
                                        //         width: 120,
                                        //         height: 50,
                                        //         padding: EdgeInsets.all(15),
                                        //         decoration: BoxDecoration(
                                        //             borderRadius: BorderRadius.circular(50),
                                        //             color: Colors.blue[800]
                                        //         ),
                                        //         child: Center(child: Text("Cancel", style: TextStyle(fontSize:15,color: Colors.white),)),
                                        //       ),
                                        //     ),
                                        //     InkWell(
                                        //       onTap: () async {
                                        //
                                        //         if (_formKey.currentState!.validate()) {
                                        //
                                        //           await ref1.child("Users").child(userAuth.currentUser!.uid).update({
                                        //             "name": nameController.text.trim(),
                                        //             "email": emailController.text.trim(),
                                        //             "phoneNumber": emailController.text.trim(),
                                        //             "address" : addressController.text.trim(),
                                        //           });
                                        //           setState(() {
                                        //
                                        //           });
                                        //         }
                                        //
                                        //         //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_Screen()));
                                        //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes Saved')),);
                                        //
                                        //       },
                                        //       child: Container(
                                        //         width: 120,
                                        //         height: 50,
                                        //         padding: EdgeInsets.all(15),
                                        //         decoration: BoxDecoration(
                                        //             borderRadius: BorderRadius.circular(50),
                                        //             color: Colors.blue[800]
                                        //         ),
                                        //         child: Center(child: Text("Save", style: TextStyle(fontSize:15,color: Colors.white),)),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    );
                                  }
                                }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        initialValue: placeholder, style:  TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        ),

        validator: (value){
          if(labelText=="name"){
            if (value == null || value.isEmpty) {
              return 'Required Field';
            }
            if (!validator.name(value)) {
              return 'Please enter full name and first letter in caps';
            }
            return null;
          }

          if(labelText=="email"){
            if (value == null || value.isEmpty) {
              return 'Please Enter Email';
            }
            if(!validator.email(value))
            {
              return 'Please enter Valid Email';
            }
            return null;
          }

          if(labelText=="address"){
            if (value == null || value.isEmpty) {
              return 'Required Field';
            }
            return null;
          }

        },

        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}