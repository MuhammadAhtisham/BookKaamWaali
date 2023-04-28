import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
class Feedback_Screen extends StatefulWidget {
  String employeeKey, order;
  Feedback_Screen({Key? key, required this.employeeKey, required this.order}) : super(key: key);

  @override
  State<Feedback_Screen> createState() => _Feedback_ScreenState();
}

class _Feedback_ScreenState extends State<Feedback_Screen> {
  @override
  double value = 3.5;
  TextEditingController Controller =TextEditingController();
  late DatabaseReference reference = FirebaseDatabase.instance.ref().child('Employees');
  String serviceProviderCNIC="", feedback="", rating="";


  void getEmployeeData() async {
    DataSnapshot snapshot = await reference.child(widget.employeeKey).get();
    Map employee = snapshot.value as Map;
    feedback = (employee['feedBack']).toString();
    rating = (employee['rating']).toString();
    serviceProviderCNIC = (employee['cnic']).toString();
    print(feedback);
    print("zara");
  }

  @override
  void initState() {
    print(widget.employeeKey);
    // TODO: implement initState
    super.initState();
    getEmployeeData();
  }
  // getOrder() async{
  //   late DatabaseReference dbref;
  //   dbref = await FirebaseDatabase.instance.ref("Employees");
  //
  //   dbref.once().then((DatabaseEvent event){
  //     if(event.snapshot.value == null){
  //       print("Not Avaiable");
  //     }
  //     else{
  //       Map<String, dynamic>.from(event.snapshot.value as dynamic).forEach((key, value) {
  //
  //         if(value["gender"]==widget.gender && value["services"].contains(widget.service))
  //         {
  //           Navigator.push(context, MaterialPageRoute(builder: (context) => Select_Employee(service: widget.service, allServices: widget.allServices, gender: widget.gender, frequency: widget.frequency, price: widget.price, additionalPrice: widget.additionalPrice , year: "2023", month: "Feb", day: _selectedDay.toString(), hour: _selectedHour, repeat: "No Repeat")),);
  //           check= true;
  //
  //         }
  //       });
  //     }
  //   });
  //
  // }

  Widget build(BuildContext context) {
    getEmployeeData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 7),
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.blueAccent,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.0, right: 20.0, left: 20.0),
              child: Text(
                'Please Give \nFeedBack?',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
              child:Center(
                child: RatingStars(
                  value: value,
                  onValueChanged: (v) {
                    //
                    setState(() {
                      value = v;
                    });
                  },
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 30,
                  valueLabelColor: Color(0xff9b9b9b),
                  valueLabelTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: Duration(milliseconds: 1000),
                  valueLabelPadding:
                  EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  valueLabelMargin: EdgeInsets.only(right: 12),
                  starOffColor: Color(0xffe7e8ea),
                  starColor: Colors.yellow,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding : EdgeInsets.only(left:10.0, right:10.0,top: 4.0, bottom:0.0),
              width: 280,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.blueAccent, width: 2,) ,

              ),
              child:  TextFormField(
                maxLines: 5,
                controller: Controller,
                decoration: InputDecoration(
                  hintText: 'Please Enter Feedback here',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter feedback';
                  }
                  return null;
                },
                onSaved: ( value){
                  var fname = value!;
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
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
                  child: TextButton
                    (
                    onPressed: () async {

                      DatabaseReference dbref = FirebaseDatabase.instance.ref();
                      DatabaseReference dbref1 = FirebaseDatabase.instance.ref();

                      dbref.child("Employees").child(widget.employeeKey).update({
                        "rating": rating + ", " + value.toString(),
                        "feedBack" :  feedback + ", " + Controller.text,
                      });

                      dbref1.child("Orders").child(widget.order).update({
                        "serviceProviderCNIC": serviceProviderCNIC,
                        "status" : "Completed",
                        "feedback" : Controller.text,
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Page()),);
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

          ],
        ),
      ),
    );
  }
}