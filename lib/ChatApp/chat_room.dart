import 'dart:io';

import 'package:bookkaamwaali/Design/InputDeco_design.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class ChatRoomScreen extends StatefulWidget {

  Map<String, dynamic> userMap = {};
  String chatId;
  /// we removed required from this.age and put ? in below line which means age can also be empty
  int? age;
  ChatRoomScreen({Key? key, required this.userMap, this.age, required this.chatId}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {

  TextEditingController sendController = TextEditingController();
  Common obj_common = Common();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  ///send message function
  void setMessageData() async
  {
    Map<String, dynamic> message={
      "message" : sendController.text.trim(),
      "sendby" : FirebaseAuth.instance.currentUser!.email,
      "type": "text",
      "time" : FieldValue.serverTimestamp(),
    };
    ///ADD works same as set but also gives unique id like push
    await firebaseFirestore.collection('UserChat').doc(widget.chatId).collection('chat').add(message);
    sendController.clear();
  }

  ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  ///image functionality
  Future getImage() async{
    await imagePicker.pickImage(source: ImageSource.gallery).then((value){
      if(value!=null)
        {
          imageFile = File(value.path);
          uploadImage();
        }
    });
  }
  Future uploadImage() async{
    String UniqueFileName = Uuid().v1();
    int status = 0;

    await firebaseFirestore.collection('UserChat').doc(widget.chatId).collection('chat').doc(UniqueFileName).set({
      "message" : "",
      "sendby" : FirebaseAuth.instance.currentUser!.email,
      "type": "img",
      "time" : FieldValue.serverTimestamp(),
    });
    var ref = await firebaseStorage.ref().child('messageImages').child("$UniqueFileName.jpg");
    var uploadImageTask = await ref.putFile(imageFile!).catchError((error){
      firebaseFirestore.collection('UserChat').doc(widget.chatId).collection('chat').doc(UniqueFileName).delete();
      status = 1;
    });
   if(status==0){
     String ImagePath = await uploadImageTask.ref.getDownloadURL();

     await firebaseFirestore.collection('UserChat').doc(widget.chatId).collection('chat').doc(UniqueFileName).update({
       "message" : ImagePath,
       "time" : FieldValue.serverTimestamp(),

     });
   }

    // print(ImagePath);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
           title:  StreamBuilder(
             stream: firebaseFirestore.collection('User').doc(widget.userMap['uid']).snapshots(),
             builder: (context,snapShot){
               if(!snapShot.hasData){
                 return Center(child: CircularProgressIndicator(),);
               }else{
                 return Container(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        Text(widget.userMap['name'],style: TextStyle(fontSize: 12.0),),
                        Text(widget.userMap['status'],style: TextStyle(fontSize: 14.0),),
                     ],
                   ),
                 );
               }
             },
           ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore.collection('UserChat').doc(widget.chatId).collection('chat').orderBy('time', descending:false).snapshots(),
          builder: (builder,snapShot)
          {
            if(!snapShot.hasData)
              {
                return Center(child: CircularProgressIndicator(),);
              }
            else
              {
                return Container(
                  child: ListView.builder(
                    itemCount: snapShot.data!.docs.length,
                    itemBuilder: (context, index){
                    return  snapShot.data!.docs[index]['type'] == "text" ?
                    Container(
                      alignment: snapShot.data!.docs[index]['sendby'] == FirebaseAuth.instance.currentUser!.email
                        ?Alignment.centerRight
                        :Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Text(snapShot.data!.docs[index]['message']))) :
                        Container(
                          alignment: snapShot.data!.docs[index]['sendby'] == FirebaseAuth.instance.currentUser!.email
                              ?Alignment.centerRight
                              :Alignment.centerLeft,
                          child: Container(
                            height: 100,
                              width: 100,
                              child: Image.network(snapShot.data!.docs[index]['message'] )),
                        );

              }),
                );
              }
          }
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              ///TextField
              ///navigation bar requires height width for text field that's why we use expanded
              Expanded(
                  child:TextField(
                    controller : sendController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: getImage, icon: Icon(Icons.image)),
                      prefixIcon: Icon(Icons.send,
                        color: Color(0xFF3E3E61),),
                        hintText: "type message here...",
                    ),

                    cursorColor: Color(0xFF3E3E61),
                    style: obj_common.TextStyleWidget(),
                  ),
              ),
              ///Send Icon Button
              Container(
                child: IconButton(
                  onPressed: setMessageData,
                    icon: Icon(Icons.send),
                ),

              ),
            ],
          ),
        ),
      ),

    );
  }
}

