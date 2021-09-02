import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Container(
            decoration: BoxDecoration(
              color:Colors.green,
            ),
            child: Text('Hi Container 1'),
          ),
        ]
      )
    );
  }
}