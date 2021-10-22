import 'package:byu_studies/screens/Browse.dart';
import 'package:flutter/material.dart';
import 'screens/Home.dart';
import 'screens/Journals.dart';
import 'screens/Articles.dart';
import 'screens/ArticleDetails.dart';
import 'screens/SearchResults.dart';
import 'screens/AuthorDetails.dart';

class Shell extends StatefulWidget {
  @override
  _Shell createState() => _Shell();
}
class _Shell extends State<Shell> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;
  //first build gets set to false as soon as widget is built and stays false-- meant to prevent error when first building and setting a state TODO:should probably find a better solution
  var firstBuild = true;

  List<String> _widgetOptions =["/","/journals","/browse"];
  bool needsBackButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        initialRoute: '/',
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          var back=false;
          switch (settings.name) {
            case '/':
              back=false;
              builder = (BuildContext context) =>  Home();
              break;
            case '/journals':
              back=false;
              builder = (BuildContext context) => Journals();
              break;
            case '/browse':
              back=false;
              builder = (BuildContext context) =>  Browse();
              break;
            case '/articles':
              back=true;
              builder = (BuildContext context) => Articles();
              break;
            case '/article_detail':
              back=true;
              builder = (BuildContext context) => ArticleDetail();
              break;
            case '/search_results':
              back=true;
              builder = (BuildContext context) => SearchResults();
              break;
            case '/author_details':
              back=true;
              builder = (BuildContext context) => AuthorDetails();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          if(!firstBuild){
            setState(() {
              needsBackButton=back;
            });
          }
          firstBuild=false;
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
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: 'Browse',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index){
          if(index!=_selectedIndex) {
            setState(() {
              _selectedIndex = index;
              _navigatorKey.currentState!.pushNamed(
                  _widgetOptions[_selectedIndex]
              );
            });
          }
          //Navigator.of(context).pushNamed('/journals');
          //Navigator.of(context).pushReplacementNamed("/journals"/*_widgetOptions[_selectedIndex]*/);
        },
      ),
    );
  }
  void makeBackButton(bool backButton){
    setState(() {
      needsBackButton=backButton;
    });
  }
}