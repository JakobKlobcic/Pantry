
import 'package:byu_studies/screens/RecepiesDetails.dart';
import 'package:flutter/material.dart';
import 'models/RouteArguments.dart';
import 'screens/AddFoods.dart';
import 'screens/AddToCart.dart';
import 'screens/Home.dart';
import 'screens/Recepies.dart';
import 'screens/ShoppingList.dart';

class Shell extends StatefulWidget {
  @override
  _Shell createState() => _Shell();
}
class _Shell extends State<Shell> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;
  //first build gets set to false as soon as widget is built and stays false-- meant to prevent error when first building and setting a state TODO:should probably find a better solution
  var firstBuild = true;
  //TODO: Browse --> Explore
  List<String> _widgetOptions =["/","/recepies","/shoppingList"];
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
            case '/addFoods':
              back=false;
              builder = (BuildContext context) => AddFoods();
              break;
            case '/addToCart':
              back=false;
              builder = (BuildContext context) => AddToCart();
              break;
            case '/recepies':
              back=false;
              builder = (BuildContext context) => Recepies();
              break;
            case '/recepieDetails':
              back=false;
              builder = (BuildContext context) => RecepieDetails();
              break;
            case '/shoppingList':
              back=false;
              builder = (BuildContext context) =>  ShoppingList();
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
            icon: Icon(Icons.home_filled),
            label: 'Pantry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.blender),
            label: 'Recepies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store),
            label: 'Shopping List',
          ),
        ],
        currentIndex: _selectedIndex,
        //#7ED957
        selectedItemColor:Color(0xff7ED957),
        onTap: (int index){
          if(index!=_selectedIndex) {
            setState(() {
              _selectedIndex = index;
              _navigatorKey.currentState!.pushNamed(
                  _widgetOptions[_selectedIndex], arguments: new Arguments(key:_navigatorKey)
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