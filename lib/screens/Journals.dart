import 'package:flutter/material.dart';
import '../fetch_data.dart';

class Journals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FetchData().fetchJournalList().then((result) {
      print(result);
    });
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              Container(
                decoration: BoxDecoration(
                  color:Colors.blue,
                ),
                child: Text('Journals Screen'),
              ),
            ]
        )
    );
  }
}