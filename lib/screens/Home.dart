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
                  FetchData().fetchJournalList().then((result) {
                    print(result);
                  })
                },
                child: new Text('Click me'),
              ),
            ]
        )
    );
  }
}