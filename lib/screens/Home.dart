import 'package:flutter/material.dart';


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
        ]
      )
    );
  }
}