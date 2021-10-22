import 'package:byu_studies/screens/ArticleDetails.dart';
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

class _Browse extends State<Browse> with SingleTickerProviderStateMixin {
  final _subNavigatorKey = GlobalKey<NavigatorState>();
  String enteredSearch ="";
  bool s = true;
  late final TabController _tabController;


  //final TextEditingController _controller = new TextEditingController();
  @override
  void initState() {

    /*_tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        print("change tab");
        _handleTabSelection();
      }
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        switch(_tabController.index){
          case 0:
            _subNavigatorKey.currentState!.pushNamed("/browse/downloaded");
            break;
          case 1:
            _subNavigatorKey.currentState!.pushNamed("/browse/tags");
            break;
          case 2:
            _subNavigatorKey.currentState!.pushNamed("/browse/authors");
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
          leading: Container(),
        ),
        body: s?
        Navigator(
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
              case '/browse/downloaded_details':
                builder = (BuildContext context) =>  ArticleDetail();
                break;
              case '/browse/tag_details':
                builder = (BuildContext context) =>  TagDetails();
                break;
              case '/browse/author_details':
                builder = (BuildContext context) =>  AuthorDetails();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
            }/*
            if(!firstBuild){
              setState(() {
                needsBackButton=back;
              });
            }
            firstBuild=false;*/
            return MaterialPageRoute<void>(builder: builder, settings: settings);
          },
        ):TabBarView(
          children: [
            BrowseDownloaded(),
            BrowseTags(),
            BrowseAuthors(),
          ],
        ),
      ),
    );
  }
}
