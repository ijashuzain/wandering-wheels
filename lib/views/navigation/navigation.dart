import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/views/home/home_main.dart';
import 'package:wandering_wheels/views/management/manage_home.dart';
import 'package:wandering_wheels/views/booking/booking_my.dart';
import 'package:wandering_wheels/views/profile/profile.dart';

class Navigation extends StatefulWidget {
  static String routeName = "/navigation";
  @override
  _NavigationState createState() => _NavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavigationState extends State<Navigation> {
  
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const MyBooking(),
    const ManageHome(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Consumer<UserProvider>(
          builder: (context, provider,child) {
            return BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 10,
              type: BottomNavigationBarType.fixed,
              iconSize: 30,
              items:  <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home"
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_added),
                  label: "Bookings"
                ),
                if (provider.currentUser!.type == "Admin")  const BottomNavigationBarItem(
                  icon: Icon(Icons.cases_sharp),
                  label: "Manage"
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile"
                )
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: Colors.grey[400],
              onTap: _onItemTapped,
            );
          }
        ),
      ),
    );
  }
}
