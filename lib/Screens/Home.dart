import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Container(
              constraints: BoxConstraints.expand(height: 200.0),
              decoration: BoxDecoration(color: Colors.grey),
              child: Image.asset(
                "assets/images/lake_bled.jpeg",
                fit: BoxFit.cover,
              )
          ),
          Container(
            decoration: BoxDecoration(
              color:Colors.green,
            ),
            child: Text('Hi Container 1'),
          ),

          Container(
            decoration: BoxDecoration(
              color:Colors.red,
            ),
            child: Text('Hi Container 2'),
          ),

          Container(
            decoration: BoxDecoration(
              color:Colors.blue,
            ),
            child: Text('Hi Container 3'),
          )
        ]
      )
    );
  }
}