import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override

  Query dbRef = FirebaseDatabase.instance.ref().child('Orders');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Orders');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        toolbarHeight: 45,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 4),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body:Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              color: Colors.blueAccent,
            ),
            child: Center(
              child: Text(
                'Orders History',
                style: TextStyle(color:Colors.white,fontSize: 40, fontWeight: FontWeight.w500),
              ),
            ),
          ),
         Container(
           padding: EdgeInsets.only(left: 20, top: 155, right: 20),
           child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: FirebaseAnimatedList(
                    query: dbRef,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index)
                    {
                      Map order = snapshot.value as Map;
                      order['key'] = snapshot.key;

                      return listItem(order: order, index: index);
                    },

                  ),
                ),
           ),
         ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: transaction.length,
          //   itemBuilder: (context, index) {
          //     return TransactionContainer(transaction: transaction[index]);
          //   },
          // ),
        ],
      ),
    );
  }

  Widget listItem({required Map order, required int index})
  {
    print("zara");
    if(order["userId"]==FirebaseAuth.instance.currentUser!.uid.toString())
      {
        return Container(
        child: Padding(
          padding: EdgeInsets.only(top: 18.0, right: 10.0, left: 10.0),
          child: GestureDetector(
            onTap: (){

            },
          child: Padding(
            padding:EdgeInsets.all(2.0),
            child: AspectRatio(
              aspectRatio:7/3,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color:Colors.pink,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(order["date"], style: TextStyle(fontSize: 15,color: Colors.blueAccent),),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(order["serviceProvider"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Text(order["services"], style: TextStyle(fontSize: 15),),
                              SizedBox(height: 5,),
                              Text(order["totalPayment"], style: TextStyle(fontSize: 15),)
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 5,),
                              Icon(Icons.check, color: Colors.green, size: 20,)
                            ],
                          )
                        ]
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
      }
    else{
      return Text("");
    }
  }
}