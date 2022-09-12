import 'package:bookkaamwaali/Profile/Profile.dart';
import 'package:bookkaamwaali/Profile/User_List.dart';
import 'package:bookkaamwaali/Profile/edit_Profile.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import '../home_screen/homescreen.dart';

// class SidebarXExampleApp extends StatelessWidget {
//   SidebarXExampleApp({Key? key}) : super(key: key);
//
//   final _controller = SidebarXController(selectedIndex: 0, extended: true);
//   final _key = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       home: Builder(
//         builder: (context) {
//           final isSmallScreen = MediaQuery.of(context).size.width < 600;
//           return Scaffold(
//             key: _key,
//
//               drawer: ExampleSidebarX(controller: _controller),
//             appBar: AppBar(
//               backgroundColor: canvasColor,
//               title: Text(_getTitleByIndex(_controller.selectedIndex)),
//               leading: IconButton(
//                 onPressed: () {
//                   _controller.setExtended(true);
//                   _key.currentState?.openDrawer();
//                 },
//                 icon: const Icon(Icons.menu),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SidebarX(
        controller: _controller,
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: scaffoldBackgroundColor,
          textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          selectedTextStyle: const TextStyle(color: Colors.white),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            gradient: const LinearGradient(
              colors: [accentCanvasColor, canvasColor],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme: const SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: canvasColor,
          ),
        ),
         footerDivider: divider,
        // headerBuilder: (context, extended) {
        //   return SizedBox(
        //     height: 100,
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Image.asset('assets/images/avatar.png'),
        //     ),
        //   );
        // },
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
              onTap: () => selectedItem(context, 0),
          ),
          SidebarXItem(
            icon: Icons.search,
            label: 'Search User',
            onTap: () => selectedItem(context, 1),
          ),
          SidebarXItem(
            icon: Icons.person,
            label: 'Profile',
            onTap: () => selectedItem(context, 2),
          ),
          SidebarXItem(
            icon: Icons.favorite,
            label: 'Favorite',
            onTap: () => selectedItem(context, 3),
          ),
          SidebarXItem(
            iconWidget: FlutterLogo(size: 20),
            onTap: () => selectedItem(context, 4),
            label: 'Flutter',
          ),
        ],
      ),
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    default:
      return 'Not found page';
  }
}



void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      break;
    case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> User_List()));
      break;
    case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
      break;
  }
}
const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
// const scaffoldBackgroundColor = Color(0xFF464667);
const scaffoldBackgroundColor = Colors.white;
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);