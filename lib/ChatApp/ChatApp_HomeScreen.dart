import 'package:bookkaamwaali/ChatApp/chat_room.dart';
import 'package:bookkaamwaali/ChatApp/user_search.dart';
import 'package:bookkaamwaali/register_login_screen/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChatAppHome extends StatefulWidget {
  const ChatAppHome({Key? key}) : super(key: key);

  @override
  State<ChatAppHome> createState() => _ChatAppHomeState();
}

class _ChatAppHomeState extends State<ChatAppHome> with WidgetsBindingObserver{
  late double height;
  late double width;



  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore  firebaseFirestore = FirebaseFirestore.instance;

  int b = 0; //flutter
  RxInt a=0.obs; //getX

  void add()
  {
    a= a + 1;
    ///setState reloads whole screen to set
    setState((){});
  }

  ///chat id function
  String roomChatId(String? user1, String? user2)
  {
    if(user1!.toLowerCase().codeUnits[0] > user2!.toLowerCase().codeUnits[0])
      { //123 > 456
        return "$user1$user2"; //123456
      }
    else{
      return "$user2$user1"; //456123

    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    userStatus("online");
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      // online
      userStatus("online");
    }else{
      //offline
      userStatus("offline");
    }
  }
  /// update user status
  void userStatus(String status)async{
    await firebaseFirestore.collection('User').doc(auth.currentUser!.uid).update({
      "status":status,
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Color(0xFF2E2E48),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchUserScreen()));
            }
            , icon: Icon(Icons.search)
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
             child: Column(
               children: [
                 Text('Welcome ${auth.currentUser!.displayName}'),
                IconButton(onPressed: (){
                  Get.defaultDialog(
                    title: "Alert",
                    content: Text("Are you sure"),
                    actions: [
                      TextButton(onPressed: (){
                        auth.signOut();
                        Get.to( LoginScreen());
                      },
                      child: Text("yes"),),
                      TextButton(onPressed: (){
                        Get.back();
                      },
                        child: Text("yes"),),
                    ],
                  );

                }
                    , icon: Icon(Icons.logout)
                ),
                 SizedBox(height: 10),
                 Obx((){ return Text(a.toString());}),
                 SizedBox(height: 10),
                 IconButton(onPressed: add, icon: Icon(Icons.add)),
                 Expanded(
                   child: Container(
                     child: StreamBuilder<QuerySnapshot>(
                       stream: firebaseFirestore.collection('User').where("email", isNotEqualTo : FirebaseAuth.instance.currentUser!.email).snapshots(),
                       builder: (builder, snapshot){
                         if(!snapshot.hasData)
                           {
                             return Center(child: CircularProgressIndicator(),);
                           }
                         else{
                           return Container(
                             child: ListView.builder(
                               itemCount: snapshot.data!.docs.length,
                               itemBuilder: (context, index)
                               {
                                 Map<String, dynamic> userData= snapshot.data!.docs[index].data();

                                 return Card(
                                   child: ListTile(
                                     onTap: (){
                                       String chatId = roomChatId(FirebaseAuth.instance.currentUser!.uid, snapshot.data!.docs[index]['uid']);
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                           ChatRoomScreen(
                                         // userMap: userData,
                                           userMap:
                                         {
                                         "name":snapshot.data!.docs[index]['name'],
                                         "email": snapshot.data!.docs[index]['email'],
                                           "status":  snapshot.data!.docs[index]['status'],
                                         },
                                         age:12,
                                         chatId: chatId,
                                       )));
                                     },
                                     title: Text(snapshot.data!.docs[index]['name']),
                                     subtitle: Text(snapshot.data!.docs[index]['email']),
                                   ),
                                 );
                               }
                             ),
                           );
                         }
                       }
                     ),
                   ),
                 ),
               ],
             ),
        ),
      ),
    );
  }
}
///we use future builder to get data from real database
///we use stream builder to get data from firestore database
///WidgetsBindingObserver is used to get user status

/// State Management is also a mini framework - provider//getX/blockC.

