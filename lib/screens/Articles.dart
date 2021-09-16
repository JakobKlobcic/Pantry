import 'package:flutter/material.dart';
import '../models/Journal.dart';

class Articles extends StatelessWidget {
  Articles(){
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children:[
          Text("journal.title"),
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