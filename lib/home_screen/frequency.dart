import 'package:bookkaamwaali/home_screen/calendarScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Frequency extends StatefulWidget {
  String service, gender, allServices;
  int additionalPrice;
  Frequency({Key? key, required this.service, required this.gender, required this.allServices, required this.additionalPrice}) : super(key: key);

  @override
  State<Frequency> createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {

  late String dailyFrequency="Rs. 0", weeklyFrequency= "Rs.0", monthlyFrequency="Rs. 0";
  showPayment(){
    DatabaseReference dbref = FirebaseDatabase.instance.ref().child("Services");
    dbref.once().then((DatabaseEvent event) {
      if (event.snapshot.value == null) {
        print("no data");
      }
      else {
        Map<String, dynamic>.from(event.snapshot.value as dynamic).forEach((key, value) {


          if(value["serviceName"]==widget.service)
          {
            dailyFrequency = value['pricePerDay'];
            weeklyFrequency = value['pricePerWeek'];
            monthlyFrequency= value['pricePerMonth'];
          }
        });
      }
    });
    setState(() {});
  }
  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  final List<dynamic> _quantity =[
    ['Daily', 'https://img.icons8.com/color/2x/tear-off-calendar.png', Colors.red, 0],
    ['Weekly', 'https://img.icons8.com/color/2x/tear-off-calendar.png', Colors.orange, 0],
    ['Monthly', 'https://img.icons8.com/color/2x/tear-off-calendar.png', Colors.purple, 0],
  ];
  List<int> _selectedquantity = [];
  late int selectedIndex = 0;
  late String frequency;
  late String price = "0";
  late int addtionalPrice = 0;

  Widget build(BuildContext context) {
    showPayment();
    setState(() {});
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
        backgroundColor: Colors.white,
        floatingActionButton: _selectedquantity.length > 0 ? FloatingActionButton(
          onPressed: () {

             if(frequency=='Daily') {
               print(price);
               price = dailyFrequency;
             }
             if(frequency=='Weekly')
               price = weeklyFrequency;
             if(frequency=='Monthly')
               price = monthlyFrequency;

             Navigator.push(context, MaterialPageRoute(builder: (context) => DateAndTime(service: widget.service, allServices: widget.allServices, gender: widget.gender, frequency: frequency, price: price, additionalPrice: widget.additionalPrice)),);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('${_selectedquantity.length}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // SizedBox(width: 2),
              Icon(Icons.arrow_forward_ios, size: 18,),
            ],
          ),
          backgroundColor: Colors.blue,
        ) : null,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0, bottom: 15),
                  child: Text(
                    'Select Frequency?',
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
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _quantity.length,
                itemBuilder: (BuildContext context, int index) {
                  return Frequency(_quantity[index], index, dailyFrequency);

                }
            ),
          ),
        )
    );
  }
  Frequency(List pairs, int index, String price) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex= index;

          if (_selectedquantity.contains(index))
          {
            // _selectedquantity.remove(index);
            //  _selectedquantity.clear();
          }
          else {
            // _selectedquantity.remove(index-1);
            _selectedquantity.clear();
            _selectedquantity.add(index);
          }
        });
        if(selectedIndex==index){
          print(pairs[1]);
          frequency = pairs[0];

        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          margin: EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: selectedIndex==index && _selectedquantity.length > 0 ? pairs[2].shade50.withOpacity(0.5) : Colors.grey.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Image.network(pairs[1], width: 35, height: 35,),
                      SizedBox(width: 10.0,),
                      Text(pairs[0], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  Spacer(),
                  selectedIndex==index && _selectedquantity.length > 0 ?
                  Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade100.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(Icons.check, color: Colors.green, size: 20,)
                  ) :
                  SizedBox()
                ],
              ),
              (_selectedquantity.contains(index) && pairs[3] >= 1) ?
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    Text("How many ${pairs[0]}s?", style: TextStyle(fontSize: 15),),
                    SizedBox(height: 10.0,),
                    Container(
                      height: 45,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  pairs[3] = index + 1;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.all(10.0),
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: pairs[3] == index + 1 ? pairs[2].withOpacity(0.5) : pairs[2].shade200.withOpacity(0.5),
                                ),
                                child: Center(child: Text((index + 1).toString() , style: TextStyle(fontSize: 22, color: Colors.white),)),
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              ) : SizedBox()
            ],
          )
      ),
    );
  }
}