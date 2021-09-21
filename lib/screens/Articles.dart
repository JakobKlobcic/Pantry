import 'package:flutter/material.dart';
import '../models/Journal.dart';

class Articles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Journal journal = ModalRoute.of(context)!.settings.arguments as Journal;
    return Scaffold(
      body:Column(
        children:[
          Text(journal.title,style: const TextStyle(fontWeight: FontWeight.bold),),
          ElevatedButton(
            onPressed: () => {

              Navigator.pop(context)
            },
            child: new Text('Click me'),
          ),
        ]
      )
    );
  }

}