import 'package:flutter/material.dart';
import 'package:karetaker/presentation/nav/home.dart';

import 'nav/appointments.dart';
import 'nav/blogs.dart';
import 'nav/profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = [
    HomePage(),
    BlogPage(),
    AppointmentPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        onPressed: () {
          print('Services Button Clicked');
        },
        child: Icon(
          Icons.where_to_vote_rounded,
          color: Colors.red,
          size: 60,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 6,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              label: 'Blogs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ]),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
