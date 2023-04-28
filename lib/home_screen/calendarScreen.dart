import 'package:bookkaamwaali/home_screen/employeePage.dart';
import 'package:bookkaamwaali/home_screen/frequency.dart';
import 'package:bookkaamwaali/home_screen/homeScreen.dart';
import 'package:bookkaamwaali/home_screen/paymentPages/paymentByCard.dart';
import 'package:bookkaamwaali/home_screen/paymentPages/paymentOptions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DateAndTime extends StatefulWidget {
  String service, allServices, gender, frequency, price;
  int additionalPrice;
   DateAndTime({ Key? key, required this.service,required this .allServices, required this.gender, required this.frequency,  required this.price, required this.additionalPrice }) : super(key: key);

  @override
  _DateAndTimeState createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {

  int _selectedDay = 2;
  int _selectedRepeat = 0;
  String _selectedHour = '13:00';
  String _selectedMonth = 'FEB';
  int _selectedMonth1 = 2;
  List<int> _selectedExteraCleaning = [];

  ItemScrollController _scrollController = ItemScrollController();

  final List<dynamic> _days = [
    [1, 'Wed'],
    [2, 'Thu'],
    [3, 'Fri'],
    [4, 'Sat'],
    [5, 'Sun'],
    [6, 'Mon'],
    [7, 'Tue'],
    [8, 'Wed'],
    [9, 'Thu'],
    [10, 'Fri'],
    [11, 'Sat'],
    [12, 'Sun'],
    [13, 'Mon'],
    [14, 'Tue'],
    [15, 'Wed'],
    [16, 'Thu'],
    [17, 'Fri'],
    [18, 'Sat'],
    [19, 'Sun'],
    [20, 'Mon'],
    [21, 'Tue'],
    [22, 'Wed'],
    [23, 'Thu'],
    [24, 'Fri'],
    [25, 'Sat'],
    [26, 'Sun'],
    [27, 'Mon'],
    [28, 'Tue'],
  ];
  final List<dynamic> _months = [
    [1, 'JAN'],
    [2, 'FEB'],
    [3, 'MAR'],
    [4, 'APR'],
    [5, 'MAY'],
    [6, 'JUN'],
    [7, 'JUL'],
    [8, 'AUG'],
    [9, 'SEP'],
    [10, 'OCT'],
    [11, 'NOV'],
    [12, 'DEC'],
  ];
  final List<String> _hours = <String>[
    '00:00',
    '00:30',
    '01:00',
    '01:30',
    '02:00',
    '02:30',
    '03:00',
    '03:30',
    '04:00',
    '04:30',
    '05:00',
    '05:30',
    '06:00',
    '06:30',
    '07:00',
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00',
    '22:30',
    '23:00',
    '23:30',
  ];

  final List<String> _repeat = [
    'Repeat',
    'No repeat',
  ];

  final List<dynamic> _exteraCleaning = [
    ['Washing', 'https://img.icons8.com/office/2x/washing-machine.png', '10'],
    ['Fridge', 'https://img.icons8.com/cotton/2x/fridge.png', '8'],
    ['Oven', 'https://img.icons8.com/external-becris-lineal-color-becris/2x/external-oven-kitchen-cooking-becris-lineal-color-becris.png', '8'],
    ['Vehicle', 'https://img.icons8.com/external-vitaliy-gorbachev-blue-vitaly-gorbachev/2x/external-bycicle-carnival-vitaliy-gorbachev-blue-vitaly-gorbachev.png', '20'],
    ['Windows', 'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-window-interiors-kiranshastry-lineal-color-kiranshastry-1.png', '20'],
  ];
  bool checkEmployee = false;
  checkEmployeeAvailability() async{
    late DatabaseReference dbref;
    dbref = await FirebaseDatabase.instance.ref("Employees");

    dbref.once().then((DatabaseEvent event){
      if(event.snapshot.value == null){
        print("Not Available");
      }
      else{
        Map<String, dynamic>.from(event.snapshot.value as dynamic).forEach((key, value) {

          if(value["gender"]==widget.gender && value["services"].contains(widget.service))
            {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Select_Employee(service: widget.service, allServices: widget.allServices, gender: widget.gender, frequency: widget.frequency, price: widget.price, additionalPrice: widget.additionalPrice , year: "2023", month: "Feb", day: _selectedDay.toString(), hour: _selectedHour, repeat: "No Repeat")),);
              checkEmployee= true;

            }
        });
      }
      if(checkEmployee==false){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Center(child: Text("Try Another Service", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
            content: Padding(
                padding: EdgeInsets.only(left:20),
                child: Text("Sorry, No Employee Currently Available", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500))),
            actions: <Widget>[
              SizedBox(
                width: 90,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Page()));
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
        print("Not Avaiable");
      }
    });
  }
  bool checkTime = false;
  checkDate(){
    checkTime = false;
    var time = DateTime.now();
    int hours = int.parse(_selectedHour.substring(0,2));
    int minutes = int.parse(_selectedHour.substring(3,5));
    print(minutes);
    if(time.month>_selectedMonth1){
      checkTime = true;
      Fluttertoast.showToast(
        msg: "Choose Another Month",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: 18.0,
      );


    }
    else if(time.day>_selectedDay)
    {
      checkTime = true;
      Fluttertoast.showToast(
        msg: "Choose Another Day",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: 18.0,
      );
    }
    else if(time.hour>hours){
      checkTime = true;
      Fluttertoast.showToast(
        msg: "Choose Another Time",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: 18.0,
      );
    }
  }
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 24,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkEmployeeAvailability();
          checkDate();
          print(checkEmployee);
          print(checkTime);
          if(checkEmployee==true && checkTime==false)
           Navigator.push(context, MaterialPageRoute(builder: (context) => Select_Employee(service: widget.service, allServices: widget.allServices, gender: widget.gender, frequency: widget.frequency, price: widget.price, additionalPrice: widget.additionalPrice , year: "2023", month: _selectedMonth, day: _selectedDay.toString(), hour: _selectedHour, repeat: "No Repeat")),);
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child:Padding(
                padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                child: Text(
                  'Select Date \nand Time?',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25,),
              Row(
                children: [
                  Text("Select Date and Time"),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey.shade700,),
                  )
                ],
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFe8f0fe),
                  border: Border.all(width: 1.5, color: Colors.grey.shade200),
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _months.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMonth = _months[index][1];
                            _selectedMonth1 = _months[index][0];
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 62,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: _selectedMonth == _months[index][1] ? Colors.purple.shade100.withOpacity(0.5) : Colors.blue.withOpacity(0),
                            border: Border.all(
                              color: _selectedMonth  == _months[index][1] ? Colors.purple : Colors.white.withOpacity(0),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_months[index][0].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text(_months[index][1], style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFe8f0fe),
                  border: Border.all(width: 1.5, color: Colors.grey.shade200),
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _days.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                             _selectedDay = _days[index][0];
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 62,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: _selectedDay == _days[index][0] ? Colors.lightGreen.shade100.withOpacity(0.5) : Colors.blue.withOpacity(0),
                            border: Border.all(
                              color: _selectedDay == _days[index][0] ? Colors.lightGreen : Colors.white.withOpacity(0),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_days[index][0].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text(_days[index][1], style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFe8f0fe),
                  border: Border.all(width: 1.5, color: Colors.grey.shade200),
                ),
                child: ScrollablePositionedList.builder(
                    itemScrollController: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _hours.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedHour = _hours[index];
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: _selectedHour == _hours[index] ? Colors.orange.shade100.withOpacity(0.5) : Colors.orange.withOpacity(0),
                            border: Border.all(
                              color: _selectedHour == _hours[index] ? Colors.orange : Colors.white.withOpacity(0),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_hours[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
              SizedBox(height: 60,),



            ],
          ),
        ),
      ),
    );
  }
}