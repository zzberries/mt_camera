import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mt_camera/bluetooth_module_controls.dart';
import 'package:mt_camera/home_page.dart';
import 'camera_controls.dart';
import 'package:mt_camera/color_constants.dart';

// run the actual app
void main() => runApp(const MainApp());

// creating the main app that contains all other widgets inside
// TODO: create a starting screen that the user can press instead of loading the main app immediately
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String _title = 'Mt. Camera - Camera Mount Controller App!';

  // build the app with a stateful widget because we have a bottom navbar
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

// the stateful widget for the whole app because it changes based on navbar icon pressed
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

// the states that the stateful widget contains
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0; // the first selected state - TODO: CHANGE TO 1 TO START FROM HOME PAGE

  // the different pages based on the icons in the navbar
  static const List<Widget> _widgetOptions = <Widget>[ // the camera controls page
    HomeScreen(),
    BluetoothScreen(),
    Text(
      'Index 2: Robot Controls',
    ),
  ];

  // what happens when you select a given navbar
  void _onNavbarIconTapped(int index) {
    // set this index to whatever the index of the navbar icon is
    setState(() {
      _selectedIndex = index;
    });
  }

  // build this stateful widget which will contain all other pages
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mintCream,
      // the top bar that says app name
      appBar: AppBar(
        toolbarHeight: 80, // fixed height: TODO: change the height to be dynamic
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/unnamed.png', scale: 8),
              const Text(
                'Mt. Camera',
                style: TextStyle(
                    color: darkSlateGray,
                    fontSize: 25
                ),
              )
            ]
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[nyanza, cambridgeBlue]),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: nyanza,
        unselectedItemColor: darkSlateGray,
        backgroundColor: cambridgeBlue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Bluetooth',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.open_with),
            label: 'Mount',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavbarIconTapped,
      ),
    );
  }
}

