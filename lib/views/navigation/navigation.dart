import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/constants/colors.dart';
import 'package:wandering_wheels/providers/user_provider.dart';
import 'package:wandering_wheels/views/home/home_main.dart';
import 'package:wandering_wheels/views/management/manage_home.dart';
import 'package:wandering_wheels/views/booking/booking_my.dart';
import 'package:wandering_wheels/views/profile/profile.dart';

import '../../providers/car_provider.dart';
import '../../providers/category_provider.dart';

class Navigation extends StatefulWidget {
  static String routeName = "/navigation";
  @override
  _NavigationState createState() => _NavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{
      context.read<CategoryProvider>().fetchCategories();
      context.read<CarProvider>().fetchAllCars(context);
    });

    if (context.read<UserProvider>().currentUser!.type == "Admin") {
      _widgetOptions = <Widget>[
        Home(),
        const MyBooking(),
        const ManageHome(),
        Profile(),
      ];
    } else {
      _widgetOptions = <Widget>[
        Home(),
        const MyBooking(),
        Profile(),
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Press back button again to close the app."),),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar:
          Consumer<UserProvider>(builder: (context, provider, child) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_added), label: "Bookings"),
            if (provider.currentUser!.type == "Admin")
              const BottomNavigationBarItem(
                  icon: Icon(Icons.cases_sharp), label: "Manage"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile")
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey[400],
          onTap: _onItemTapped,
        );
      }),
    );
  }
}
