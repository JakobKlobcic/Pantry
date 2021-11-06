import 'package:flutter/material.dart';

//import 'package:flutter_html/flutter_html.dart';
//TODO: make stateful widget to change backbutton
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  late final higherContext;
  late final backButtonBool;
  late final titleString;
  BaseAppBar(var higherContext, var backButtonBool, var titleString){
    this.higherContext=higherContext;
    this.backButtonBool=backButtonBool;
    this.titleString=titleString;
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleString),
      //title: Html(data:titleString),
      leading: !backButtonBool ? Container() : BackButton(onPressed: ()=>{Navigator.pop(context)}),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/search_results");
            },
            child: Icon(
              Icons.search,
              size: 26.0,
            ),
          )
        ),
      ]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}