
import 'package:bookkaamwaali/home_screen/calendarScreen.dart';
import 'package:bookkaamwaali/home_screen/paymentPages/paymentOptions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Select_Employee extends StatefulWidget {
  String service, allServices, gender, frequency, price,  year, month, day, hour, repeat;
  int additionalPrice;
  Select_Employee({Key? key, required this.service, required this.allServices, required this.gender, required this.frequency, required this.price, required this.additionalPrice, required this.year, required this.month, required this.day, required this.hour, required this.repeat}) : super(key: key);

  @override
  State<Select_Employee> createState() => _Select_EmployeeState();
}
class _Select_EmployeeState extends State<Select_Employee> {


  Query dbRef = FirebaseDatabase.instance.ref().child('Employees');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Employees');

  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }
  double displayHeight(BuildContext context) {
    debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  List<int> _selectedemp = [];

  late int selectedIndex = 0;
  late String key;

  Widget listItem({required Map employee, required int index}) {
    if(employee["gender"]==widget.gender && employee["services"].contains(widget.service))
      {
        return GestureDetector(
          onTap: (){
            setState(() {
              selectedIndex= index;

              if (_selectedemp.contains(index))
              {
                // _selectedemp.remove(index);
                //  _selectedemp.clear();
              }
              else {
                // _selectedemp.remove(index-1);
                _selectedemp.clear();
                _selectedemp.add(index);
              }
            });
            if(selectedIndex==index){
              key = employee['key'];
            }

          },
          child: Padding(
            padding:EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                decoration: BoxDecoration(
                 color: Colors.white,
                  border: selectedIndex==index && _selectedemp.length > 0? Border.all(
                    color:  Colors.pink,
                    width: 2.0,
                  ):  Border.all(
                    color: Colors.grey.shade200,
                    width: 2.0,
                  ),
                    borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueAccent,
                      ),
                      // ClipRRect(
                      //     borderRadius: BorderRadius.circular(15.0),
                      //     child: Image.network(image),
                      // ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(employee["name"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text(widget.service, style: TextStyle(fontSize: 15),),
                          SizedBox(height: 5,),
                          Text(widget.price + "/hr", style: TextStyle(fontSize: 15),)
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("4.5", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Icon(Icons.star, color: Colors.orange, size: 20,)
                        ],
                      )
                    ]
                ),
              ),
            ),
          ),
        );
      }
    else{
      return Container();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
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
          floatingActionButton: _selectedemp.length > 0? Container(
            // margin: EdgeInsets.only(top: 30,bottom: 40,right:20,),
            // height: 80.0,
            // width: 80.0,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              // hoverColor: Colors.blue,
              // elevation: 20.0,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Select_Payment(service: widget.service, allServices: widget.allServices, gender: widget.gender, frequency: widget.frequency, price: widget.price, additionalPrice: widget.additionalPrice, year: widget.year, month: widget.month, day: widget.day, hour: widget.hour, repeat: widget.year, employeeKey: key)),);
              },
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('${_selectedemp.length}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // SizedBox(width: 2),
                  Icon(Icons.arrow_forward_ios, size: 18,),
                ],
              ),
            ),
          ):SizedBox(),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0, bottom: 15),
                    child: Text(
                      'Whom do you want for \nService?',
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Container(
                      height: displayHeight(context) * 0.8,
                      child: FirebaseAnimatedList(
                        query: dbRef,
                        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index)
                        {
                          Map employee = snapshot.value as Map;
                          employee['key'] = snapshot.key;

                              return listItem(employee: employee, index: index);
                        },

                      ),
                    ),
                  ),
                ],
              ),
            )
          )
      ),
    );
  }
}





