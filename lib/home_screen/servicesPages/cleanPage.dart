import 'package:bookkaamwaali/home_screen/servicesPages/cook__Clean_Gardener_BabySitterrPage_Masseuse.dart';
import 'package:flutter/material.dart';
class CleaningPage extends StatefulWidget {
  String service;
  CleaningPage({ Key? key, required this.service }) : super(key: key);

  @override
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  // Rooms to clean
  List<dynamic> _rooms =[
    ['Living Room', 'https://img.icons8.com/officel/2x/living-room.png', Colors.red, 0],
    ['Bedroom (+ Rs. 50/room)', 'https://img.icons8.com/fluency/2x/bedroom.png', Colors.orange, 1],
    ['Bathroom (+ Rs. 50/room)', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
    ['Kitchen (+ Rs. 200)', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
    ['Office (+ Rs.100)', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  ];

  List<int> _selectedRooms = [];
  List<int> _selectedBedRooms = [];
  List<int> _selectedBathRooms = [];
  late int selectedBedRoomIndex = 0;
  late int selectedBathRoomIndex = 0;
   late int  additionalPrice=0;
  List<String> _services = [];
   // String _service1 =  "";
  int _bedrooms = 1;
  int _bathrooms = 1;
  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.white,
        floatingActionButton: _selectedRooms.length > 0 ? FloatingActionButton(
          onPressed: () {
            // print( _services.join(", ") );
            // _service1 = _services.join(", ");
            // additionalPrice = _service1.replaceAll(new RegExp(r'[^0-9]'),'');
            // print(additionalPrice);
            if(_services.contains("Bedroom (+ Rs. 50/room)"))
              {

                additionalPrice =   (_bedrooms*50);
                print(additionalPrice);
              }
            if(_services.contains("Bathroom (+ Rs. 50/room)"))
            {
              additionalPrice = additionalPrice +  (_bathrooms*50);
            }
            if(_services.contains("Kitchen (+ Rs. 200)"))
            {
              additionalPrice = additionalPrice +  200;
            }
            if(_services.contains("Office (+ Rs.100)"))
            {
              additionalPrice = additionalPrice + 100;
            }
             print(additionalPrice);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Cook__CleanGardener_BabySitter_MasseusePage(service: widget.service, allServices: _services.join(", "), additionalPrice: additionalPrice )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('${_selectedRooms.length}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0, bottom: 8),
                  child: Text(
                    'Where do you want \nCleaning?',
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
                itemCount: _rooms.length,
                itemBuilder: (BuildContext context, int index) {
                  return room(_rooms[index], index);
                }
            ),
          ),
        )
    );
  }

  room(List room, int index) {
    return GestureDetector(
      onTap: () {

        setState(() {
          if (_selectedRooms.contains(index)) {
            _selectedRooms.remove(index);
            _services.remove(room[0]);
          }
            else {
            _services.add(room[0]);
              _selectedRooms.add(index);
            }
        });
        print(_selectedRooms);
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          margin: EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: _selectedRooms.contains(index) ? room[2].shade50.withOpacity(0.5) : Colors.grey.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Image.network(room[1], width: 35, height: 35,),
                      SizedBox(width: 10.0,),
                      Text(room[0], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    ],
                  ),
                  Spacer(),
                  _selectedRooms.contains(index) ?
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
              (_selectedRooms.contains(index) && room[3] >= 1 && room[0] == "Bedroom (+ Rs. 50/room)") ?
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    Text("How many Bedrooms?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
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
                                    selectedBedRoomIndex= index;

                                    if (_selectedBedRooms.contains(index))
                                    {
                                      // _selectedemp.remove(index);
                                      _selectedBedRooms.clear();
                                    }
                                    else {
                                      // _selectedemp.remove(index-1);
                                      _selectedBedRooms.clear();
                                      _selectedBedRooms.add(index);
                                    }
                                  });
                                  if(selectedBedRoomIndex==index && _selectedBedRooms.length > 0){
                                    _bedrooms = (index+1);

                                    print(_selectedBedRooms);


                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.all(10.0),
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color:selectedBedRoomIndex==index ? room[2].withOpacity(0.5) : room[2].shade200.withOpacity(0.5),
                                ),
                                child: Center(child: Text((index + 1).toString() , style: TextStyle(fontSize: 22, color: Colors.white),)),
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              ) : SizedBox(),
                (_selectedRooms.contains(index) && room[3] >= 1 && room[0] == "Bathroom (+ Rs. 50/room)") ?
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    Text("How many Bathrooms?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
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
                                  selectedBathRoomIndex= index;

                                  if (_selectedBathRooms.contains(index))
                                  {
                                    // _selectedemp.remove(index);
                                    _selectedBathRooms.clear();
                                  }
                                  else {
                                    // _selectedemp.remove(index-1);
                                    _selectedBathRooms.clear();
                                    _selectedBathRooms.add(index);
                                  }
                                });
                                if(selectedBathRoomIndex==index && _selectedBathRooms.length>0){
                                  _bathrooms = (index+1);
                                  print(_bathrooms);


                                }
                                // setState(() {
                                //   room[3] = index + 1;
                                // });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.all(10.0),
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: selectedBathRoomIndex==index ? room[2].withOpacity(0.5) : room[2].shade200.withOpacity(0.5),
                                ),
                                child: Center(child: Text((index + 1).toString() , style: TextStyle(fontSize: 22, color: Colors.white),)),
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              ) : SizedBox(),
            ],
          )
      ),
    );
  }
}