import 'package:bookkaamwaali/Profile/User_List.dart';
import 'package:bookkaamwaali/Profile/Profile.dart';
import 'package:bookkaamwaali/home_screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }
      if(_selectedIndex == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> User_List()));
      }
      if(_selectedIndex == 2){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Search()));
      }
      if(_selectedIndex == 3){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
      }
    });
  }
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          /// Home
          SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
          selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
          icon: Icon(Icons.favorite_border),
          title: Text("Likes"),
          selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
          icon: Icon(Icons.search),
          title: Text("Search"),
          selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile"),
          selectedColor: Colors.teal,
          ),
        ],
    );
  }
}

