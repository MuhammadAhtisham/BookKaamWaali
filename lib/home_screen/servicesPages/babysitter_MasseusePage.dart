import 'package:bookkaamwaali/home_screen/servicesPages/cook__Clean_Gardener_BabySitterrPage_Masseuse.dart';
import 'package:flutter/material.dart';

class BabySitter_MasseusePage extends StatefulWidget {
  String service;
  int additionalPrice;
  BabySitter_MasseusePage({Key? key, required this.service, required this.additionalPrice}) : super(key: key);

  @override
  State<BabySitter_MasseusePage> createState() => _BabySitter_MasseusePageState();
}

class _BabySitter_MasseusePageState extends State<BabySitter_MasseusePage> {
  @override
  List<dynamic> _quantity =[
    ['Baby Boy', 'https://img.icons8.com/color/2x/boy.png', Colors.red, 0],
    ['Baby Girl', 'https://img.icons8.com/color/2x/girl.png', Colors.orange, 0],
    ['More then 5 years', 'https://img.icons8.com/color/2x/age.png', Colors.purple, 0],
  ];


  List<int> _selectedquantity = [];
  late int selectedIndex = 0;
  late String babySitterType = "";
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
        floatingActionButton: _selectedquantity.length > 0 ? FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cook__CleanGardener_BabySitter_MasseusePage(service: widget.service, allServices: babySitterType, additionalPrice: widget.additionalPrice)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  child: widget.service=="BabySitter"? Text(
                    'Whom do you want \nDay care for?',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ): Text(
                    'Whom do you want \nMassaging for?',
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
                  return frequency(_quantity[index], index);
                }
            ),
          ),
        )
    );
  }
  frequency(List pairs, int index) {
    return GestureDetector(
      onTap: () {
      setState(() {
        selectedIndex= index;

        if (_selectedquantity.contains(index))
        {
          // _selectedquantity.remove(index);
           _selectedquantity.clear();
        }
        else {
          // _selectedquantity.remove(index-1);
          _selectedquantity.clear();
          _selectedquantity.add(index);
        }
      });
      if(selectedIndex==index &&_selectedquantity.length>0 ){
        print(pairs[1]);
        babySitterType = pairs[0];

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