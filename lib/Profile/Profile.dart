import 'package:bookkaamwaali/Design/BottomBar_Design.dart';
import 'package:bookkaamwaali/Design/SideBar_Drawer_Design.dart';
import 'package:bookkaamwaali/Profile/User_List.dart';
import 'package:bookkaamwaali/Profile/edit_Profile.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';


class Profile extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  // final _controller = SidebarXController(selectedIndex: 2, extended: true);
  // final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final name = 'Zara Asif';
    final email = 'zaraasif2000.com';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    // final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      // key: _key,
      // drawer: ExampleSidebarX(controller: _controller),
      // appBar: isSmallScreen
      //     ? AppBar(
      //   backgroundColor: canvasColor,
      //   title: Text("Home"),
      //   leading: IconButton(
      //     onPressed: () {
      //       _controller.setExtended(true);
      //       _key.currentState?.openDrawer();
      //     },
      //     icon: const Icon(Icons.menu),
      //   ),
      // )
      //     : null,
      body: SafeArea(
        child: Material(
          // color: Color.fromRGBO(50, 75, 205, 1),
          color: Color(0xFF5F5FA7),
          child: ListView(
            children: <Widget>[
              buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                onClicked: () {},
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    Divider(
                        color: Colors.white70,
                        thickness: 1,
                    ),
                    buildMenuItem(
                      text: 'Edit Profile',
                      icon: Icons.people,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    Divider(
                      color: Colors.white70,
                      thickness: 1,
                    ),
                    buildMenuItem(
                      text: 'Favourites',
                      icon: Icons.favorite_border,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    Divider(
                      color: Colors.white70,
                      thickness: 1,
                    ),
                    buildMenuItem(
                      text: 'Workflow',
                      icon: Icons.workspaces_outline,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    Divider(
                      color: Colors.white70,
                      thickness: 1,
                    ),
                    buildMenuItem(
                      text: 'Updates',
                      icon: Icons.update,
                      onClicked: () => selectedItem(context, 3),
                    ),
                    Divider(
                      color: Colors.white70,
                      thickness: 1,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Column(
            children: [
              CircleAvatar(radius: 35, backgroundImage: NetworkImage(urlImage)),
              //SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              // CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
              // )
            ],
          ),
        ),
      );



  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.pink;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      trailing:  IconButton(onPressed: onClicked, icon: Icon(Icons.add)),
      // selected: true,
      hoverColor: hoverColor,
       // onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditProfile(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => User_List(),
        ));
        break;
    }
  }
}


