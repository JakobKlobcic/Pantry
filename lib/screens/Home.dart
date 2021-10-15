import 'package:byu_studies/database/Database.dart';
import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';

import '../fetch_data.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(context,false,"BYU Studies"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Container(
            decoration: BoxDecoration(
              color:Colors.green,
            ),
            child: Text('Home Screen'),
          ),
          ElevatedButton(
            onPressed: () => {
              /*DBProvider.db.newArticle(new LocalArticle(
                id: 37192,
                title: "test Article",
                subtitle: "test Subtitle",
                type:"Article",
                authorList: "1234,4567",
                articleJournal: 44526
              ))*/
              print(DBProvider.db.getArticle())
              //DBProvider.db.deleteArticle(37192)
              /*
              FetchData().fetchJournalList().then((result) {
                print(result);
              })*/
            },
            child: new Text('Click me'),
          ),
        ]
      )
    );
  }
}