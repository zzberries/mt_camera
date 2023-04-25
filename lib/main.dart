import 'package:flutter/material.dart';

var empatheticLightYellow = const Color(0xffffcd5c);
var empatheticLightGreen = const Color(0xff96ceb5);

var cambridgeBlue = const Color(0xff7ca982);
var nyanza = const Color(0xffe0eec6);
var mintCream = const Color(0xfff1f7ed);
var darkSlateGray = const Color(0xff243e36);
var oldGold = const Color(0xffc2a83e);

void main() => runApp(const MountCameraApp());

class MountCameraApp extends StatelessWidget {
  const MountCameraApp({super.key});

  static const String _title = 'Mt. Camera - Robot Controller App!';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class CameraControlsPage extends StatelessWidget {
  const CameraControlsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('images/sidewalk_photo.jpg'),
                )
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xffc2a83e),
                child: const Text(
                  'Photo',
                  style: TextStyle(
                    color: Color(0xff243e36),
                  ),
                )
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Video',
                    style: TextStyle(
                      color: Color(0xff243e36),
                    ),
                  )
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.circle_outlined, size: 45, color: Color(0xff243e36),),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            color: const Color(0xffe0eec6),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('CANON-18'),
                    Icon(Icons.wifi),
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color(0xff243e36),
  );
  static const List<Widget> _widgetOptions = <Widget>[
    CameraControlsPage(),
    Text(
      'Index 1: Home',
      style: optionStyle,
    ),
    Text(
      'Index 2: Robot Controls',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f7ed),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/unnamed.png',
                scale: 7.5,
              ),
              const SizedBox(
                width: 70,
              ),
              const Text(
                'Mt. Camera',
                style: TextStyle(
                    color: Color(0xff243e36),
                    fontSize: 30
                ),
              )
            ]
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Color(0xffe0eec6), Color(0xff7ca982)]),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xffe0eec6),
        unselectedItemColor: const Color(0xff243e36),
        backgroundColor: const Color(0xff7ca982),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera Controls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.open_with),
            label: 'Robot Controls',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

