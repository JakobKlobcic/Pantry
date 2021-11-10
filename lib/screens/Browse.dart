import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/screens/AuthorDetails.dart';
import 'package:byu_studies/screens/BrowseAuthors.dart';
import 'package:byu_studies/screens/BrowseTags.dart';
import 'package:byu_studies/screens/BrowseDownloaded.dart';
import 'package:byu_studies/screens/TagDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Browse extends StatefulWidget{
  @override
  _Browse createState() => _Browse();
}

class _Browse extends State<Browse> with TickerProviderStateMixin {
  final _subNavigatorKey = GlobalKey<NavigatorState>();
  String enteredSearch ="";
  int index = 0;
  late final TabController _tabController;
  //late final TabController _tabController;
  //final TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    //print(args.key);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        switch(_tabController.index){
          case 0:
            setState(() {
              _subNavigatorKey.currentState!.pushNamed("/browse/downloaded", arguments: args);
            });
            break;
          case 1:
            setState(() {
              _subNavigatorKey.currentState!.pushNamed("/browse/tags", arguments: args);
            });
            break;
          case 2:
            setState(() {
              _subNavigatorKey.currentState!.pushNamed("/browse/authors", arguments: args);
            });
            break;
        }
      }
    });
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(child:Text("Downloaded\n articles")),
              Tab(child:Text("Tags")),
              Tab(child:Text("Authors")),
            ],
          ),
          title: const Text('Browse'),
          automaticallyImplyLeading: false,
        ),
        body: Navigator(
          initialRoute: '/',
          key: _subNavigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/browse/downloaded':
              case '/':
                builder = (BuildContext context) =>  BrowseDownloaded();
                break;
              case '/browse/tags':
                builder = (BuildContext context) => BrowseTags();
                break;
              case '/browse/authors':
                builder = (BuildContext context) =>  BrowseAuthors();
                break;
              case '/browse/tag_details':
                builder = (BuildContext context) =>  TagDetails();
                break;
              case '/browse/author_details':
                builder = (BuildContext context) =>  AuthorDetails();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }
            return MaterialPageRoute<void>(builder: builder, settings: new RouteSettings(name:settings.name, arguments: args));
          },
        ),
      ),
    );
  }
}
