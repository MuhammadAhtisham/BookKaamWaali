import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 7),
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
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  "Settings",
                  style: TextStyle(color:Colors.white,fontSize: 40, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 35, right: 20),
              child: Column(
                children: [

                  SizedBox(
                    height: 120,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Account",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildAccountOptionRow(context, "Change password"),
                  buildAccountOptionRow(context, "Content settings"),
                  buildAccountOptionRow(context, "Social"),
                  buildAccountOptionRow(context, "Language"),
                  buildAccountOptionRow(context, "Privacy and security"),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.volume_up_outlined,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Notifications",
                        style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildNotificationOptionRow("New for you", true),
                  buildNotificationOptionRow("Account activity", true),
                  buildNotificationOptionRow("Opportunity", false),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: BoxDecoration(
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
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                            },
                            child: Text('Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: isActive,
            onChanged: (bool val) {

            },
          ),
        ),
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Options"),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}