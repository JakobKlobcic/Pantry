import 'package:flutter/material.dart';


class Journals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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