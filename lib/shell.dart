import 'package:flutter/material.dart';
import 'screens/Home.dart';
import 'screens/Journals.dart';
import 'screens/Articles.dart';
import 'screens/ArticleDetail.dart';

class Shell extends StatefulWidget {
  @override
  _Shell createState() => _Shell();
}
class _Shell extends State<Shell> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  List<String> _widgetOptions =["/","/journals"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text('BYU Studies')),
        body: Navigator(
          initialRoute: '/',
          key: _navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            print("onGenerateRoute");
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext context) =>  Home();
                break;
              case '/journals':
                builder = (BuildContext context) => Journals();
                break;
              case '/articles':
                builder = (BuildContext context) => Articles();
                break;
              case '/article_detail':
                builder = (BuildContext context) => ArticleDetail();
                break;

              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute<void>(builder: builder, settings: settings);
          },
        ),
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
        onTap: (int index){
          print("onTap-bottomNavigation");
          setState(() {
            _selectedIndex = index;
            _navigatorKey.currentState!.pushNamed(_widgetOptions[_selectedIndex]);
          });
          //Navigator.of(context).pushNamed('/journals');
          //Navigator.of(context).pushReplacementNamed("/journals"/*_widgetOptions[_selectedIndex]*/);
        },
      ),
    );
  }
}