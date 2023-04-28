//import 'package:bookaamwaali/home_screen/homeMain.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class NeedJob extends StatefulWidget {
  const NeedJob({Key? key}) : super(key: key);

  @override
  State<NeedJob> createState() => _NeedJobState();
}

class _NeedJobState extends State<NeedJob> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  late String fname, lname, phoneNumber, email, password, confirmPassword;
  bool _isObscure = false;
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();

   DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("EmployeeJobForm");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.pink,
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.blueAccent,
                  ]
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10,),

                Container(
                  width: 325,
                  height: 630,
                 decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30,),
                        const Text(
                          'Hello, Have a good day',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Text("Please Enter Your Details",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                          ),),
                        const SizedBox(height: 30,),
                        Container(
                          width: 260,
                          height: 60,

                          child:  TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required Field';
                              }
                              if(!RegExp("^[a-zA-Z]+ [a-zA-Z]").hasMatch(value)) {
                                return 'Please enter Valid Name';
                              }
                              return null;
                            },
                            onSaved: ( value){
                              fname = value!;
                            },
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          width: 260,
                          height: 60,
                          child: TextFormField(
                            controller: cnicController,
                            decoration: InputDecoration(
                              labelText: "CNIC",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required Field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          width: 260,
                          height: 60,
                          child: TextFormField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                              return 'Required Field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          width: 260,
                          height: 60,
                          child: TextFormField(
                            controller: addressController,
                            decoration: InputDecoration(
                              labelText: "Address",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required Field';
                              }
                              return null;
                            },
                            onSaved: ( value){
                              password = value!;
                            },


                          ),
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          width: 260,
                          height: 60,
                          child: TextFormField(
                            controller: genderController,
                            decoration: InputDecoration(
                              labelText: "Gender",
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp, color: Colors.pink),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required Field';
                              }
                              return null;
                            },
                            onSaved: ( value){
                              password = value!;
                            },

                          ),
                        ),
                        const SizedBox(height: 12,),
                        Container(
                          width: 260,
                          height: 60,
                          child: TextFormField(
                            controller: servicesController,

                            decoration: InputDecoration(
                              labelText: "Select Services",
                                suffixIcon: Icon(Icons.arrow_drop_down_sharp, color: Colors.pink),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required Field';
                              }
                              return null;
                            },
                            onSaved: ( value){
                              password = value!;
                            },

                          ),
                        ),
                        const SizedBox(height: 25,),



                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            height:50,
                            width: 250,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.blueAccent,
                                      Colors.purple,
                                      Colors.blueAccent,
                                    ])
                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(5.0),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Map<String, String> jobForm = {
                                      'fullName' : nameController.text.trim(),
                                      'cnic' : cnicController.text.trim(),
                                      'phoneNumber' : phoneNumberController.text.trim(),
                                      'address' : addressController.text.trim(),
                                      'gender' : genderController.text.trim(),
                                      "services" : servicesController.text.trim(),
                                    };
                                    dbRef.push().set(jobForm);
                                    setState(() {});
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialog(
                                      // backgroundColor: Color(0xFF3c8492),
                                      // backgroundColor: Colors.black.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                      title: Center(child: Text("Employee Form", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
                                      content: Text("Your details have been saved. We will contact you soon."),
                                      actions: <Widget>[
                                        SizedBox(
                                          width: 90,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size.fromHeight(50),
                                              primary: Colors.pink,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                              // side: BorderSide(color: Colors.black),
                                              // elevation: 9.0,
                                            ),
                                            child: Text("Ok", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    );
                                  }
                                },
                                child: Text('Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17,),
                        /*InkWell(
                          onTap: () {
                          },
                          child: const Text("Or Create an account",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                         */



                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



