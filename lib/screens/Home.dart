import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../fetch_data.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
              /*Used to call database functions*/
              //journal:44526
              //article:37192
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