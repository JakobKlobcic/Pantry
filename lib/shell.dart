import 'package:flutter/material.dart';
import 'screens/Home.dart';
import 'screens/Journals.dart';

class Shell extends StatefulWidget {
  @override
  _Shell createState() => _Shell();
}
class _Shell extends State<Shell> {
  int _selectedIndex = 1;

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Journals(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text('BYU Studies')),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'All Journals',
            ),
          ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

//Navigation from: https://medium.com/@theboringdeveloper/common-bottom-navigation-bar-flutter-e3693305d2d