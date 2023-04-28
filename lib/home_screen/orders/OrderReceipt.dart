import 'package:bookkaamwaali/home_screen/servicesPages/timelinePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
class OrderReceipt extends StatefulWidget {
  String service, allServices, gender, frequency, price, year, month, day, hour, repeat, employeeKey;
  int additionalPrice;
  OrderReceipt({Key? key, required this.service, required this.allServices, required this.gender, required this.frequency,  required this.price, required this.additionalPrice, required this.year, required this.month, required this.day, required this.hour, required this.repeat, required this.employeeKey}) : super(key: key);

  @override
  State<OrderReceipt> createState() => _OrderReceiptState();
}
class _OrderReceiptState extends State<OrderReceipt> {


  late DatabaseReference dbRef, reference = FirebaseDatabase.instance.ref().child("Employees");
  int payment=0;
  late String additionalPrice;
  String serviceProvider = "";

  void getEmployeeData() async {
    DataSnapshot snapshot = await reference.child(widget.employeeKey).get();
    Map employee = snapshot.value as Map;

    serviceProvider = employee['name'];
    print(serviceProvider);
  }
  calculatePayment(){

    payment = int.parse(widget.price.replaceAll(new RegExp(r'[^0-9]'),''));
    additionalPrice = widget.additionalPrice.toString();

    payment = payment + int.parse(additionalPrice.replaceAll(new RegExp(r'[^0-9]'),''));
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    reference = FirebaseDatabase.instance.ref().child('Employees');
    dbRef = FirebaseDatabase.instance.ref().child("Orders");
    getEmployeeData();
    calculatePayment();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 7),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.blueAccent,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0, bottom: 15),
              child: Text(
                'Your Order Reciept',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
              child: Card(
                elevation: 30,
                shadowColor: Colors.black,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Table(
                        children: [
                          TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Text("Service :",textScaleFactor: 1.5, style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w600),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Text(widget.service,textScaleFactor: 1.5),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Provider :",textScaleFactor: 1.5,style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w600),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(serviceProvider,textScaleFactor: 1.5),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Frequency:",textScaleFactor: 1.5,style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w600),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(widget.frequency,textScaleFactor: 1.5),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Date:",textScaleFactor: 1.5,style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w600),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(widget.month + " " + widget.day + ",  "+ widget.year,textScaleFactor: 1.5),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Starting Time:",textScaleFactor: 1.5,style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w600),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(widget.hour, textScaleFactor: 1.5),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Charges:",textScaleFactor: 1.5,style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w600),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(widget.price,textScaleFactor: 1.5),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Additonal Charges:",textScaleFactor: 1.5,style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w600),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Rs. " + widget.additionalPrice.toString(),textScaleFactor: 1.5),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Total Payment:",textScaleFactor: 1.5,style: TextStyle(color:Colors.blueAccent, fontWeight: FontWeight.w600),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("Rs." + payment.toString(),textScaleFactor: 1.5),
                                ),
                              ]
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70.0,
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
                      Map<String, String> orders = {
                        'services' : widget.service,
                        'serviceProvider' : serviceProvider,
                        'frequency' : widget.frequency,
                        'date' : widget.month + " " + widget.day + ",  "+ widget.year,
                        'startingTime' : widget.hour,
                        "endingTime" : "",
                        'totalPayment' : "Rs." + payment.toString(),
                        'userId' : FirebaseAuth.instance.currentUser!.uid.toString(),
                        'feedback' : "",
                        'status' : "In Process"
                      };
                      DatabaseReference newRef =dbRef.push();
                      String? orderKey = (newRef.key).toString();
                      print(orderKey);
                      newRef.set(orders);
                      setState(() {});
                      // showDialog(
                      //   context: context,
                      //   // barrierDismissible: false,
                      //   builder: (context) => AlertDialog(
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      //     title: Center(child: Text("Order Confirmed", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))),
                      //     content: Padding(
                      //         padding: EdgeInsets.only(left:24, top: 10),
                      //         child: Text("Your Order is Confirmed", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500))),
                      //     actions: <Widget>[
                      //       SizedBox(
                      //         width: 90,
                      //         height: 40,
                      //         child: ElevatedButton(
                      //           onPressed: (){
                      //             Navigator.of(context).pop;
                      //              Navigator.push(context, MaterialPageRoute(builder: (context) => TimeLine(services : widget.service, startingTime : startingTimeController.text.trim(), totalPayment : paymentController.text.trim(), status : "Requested")));
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //             minimumSize: Size.fromHeight(50),
                      //             primary: Colors.pink,
                      //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      //             // side: BorderSide(color: Colors.black),
                      //             // elevation: 9.0,
                      //           ),
                      //           child: Text("Ok", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white,),),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TimeLine(order: orderKey, services : widget.service, startingTime : widget.hour, totalPayment : widget.price, status : "Requested", employeeKey: widget.employeeKey)));

                    },
                    child: Text('Continue To Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
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