import 'package:bookkaamwaali/Design/InputDeco_design.dart';
import 'package:bookkaamwaali/Utilis/Common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {

  TextEditingController searchController = TextEditingController();
  FirebaseFirestore ref = FirebaseFirestore.instance;
  Common obj_common = Common();
  Map<dynamic,dynamic> userdata = {};

  bool isLoading = false;
  /// search Function
  searchUserData() async{
    setState((){
      isLoading = true;
    });
    await ref.collection("User").where("name",isEqualTo:searchController.text.trim()).get().then((e){
        setState((){
        userdata = e.docs[0].data();
         isLoading = false;
      });
     });
    print('User Data ${userdata}');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Scaffold(
          body: Column(
            children: [
              Container(
                ///Search Bar
                margin: EdgeInsets.only(top: 40.0, left: 10, right: 10),
                child: TextField(
                      controller : searchController,
                      decoration:buildInputDecoration(Icons.person,"User Name"),
                      cursorColor: Color(0xFF3E3E61),
                      style: obj_common.TextStyleWidget(),
                  ),
                ),
              ///Search Button
              Container(
                child: ElevatedButton(
                  onPressed: searchUserData,
                  child: Text("Search User"),
                ),
              ),
              ///Show User Data
              userdata.isNotEmpty
                 ? Container(

                    child: isLoading == false? Column(
                      children: [
                        if(userdata['email'] != FirebaseAuth.instance.currentUser!.email)
                        Card(
                            elevation: 10.0,
                            child: ListTile(
                              title: Text(userdata['name']),
                              subtitle: Text(userdata['email']),
                            ),
                          ),
                      ],
                    )
                      : Container(child: CircularProgressIndicator(),)
              )
                 : Container(child: Text("No Data Found"),),
            ],
          ),

        ),
      ),
    );
  }
}
