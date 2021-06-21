import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:karetaker/Presentation/nav/features/appointment/appointment-search.dart';
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
        shape: CircleBorder(),
        backgroundColor: Colors.red,
        child: Icon(
          FontAwesomeIcons.solidHeart,
          color: Colors.white,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentSearch(),
          ),
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
              icon: Icon(Icons.bookmark),
              label: 'Blogs',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.notesMedical),
              label: 'Appointments',
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
