import 'package:flutter/material.dart';
import 'screens/Home.dart';

class Shell extends StatelessWidget {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if(index == 0){
      _selectedIndex = index;
      print('Home');
    }else if(index == 1){
      _selectedIndex = index;
      print('All Journals');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text('BYU Studies')),
        body: Home(),
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