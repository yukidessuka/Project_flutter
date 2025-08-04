import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:galleria_app/constant/app_constant.dart';
import 'package:galleria_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  final _pages = [
    Center(child: Text('Home Page', style: headingtextStyle)),
    Center(child: Text('Search Page', style: headingtextStyle)),  
    Center(child: Text('Notifications Page', style: headingtextStyle)),
    Center(child: Text('Profile Page', style: headingtextStyle)),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: _pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,
        items: [
          Icon(Icons.home, size: 30, color: secondaryColor),
          Icon(Icons.search, size: 30, color: secondaryColor),
          Icon(Icons.notifications, size: 30, color: secondaryColor),
          Icon(Icons.person, size: 30, color: secondaryColor),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
