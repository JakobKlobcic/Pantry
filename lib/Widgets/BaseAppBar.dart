import 'package:flutter/material.dart';

//import 'package:flutter_html/flutter_html.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  var higherContext;
  var backButtonBool;
  var titleString;
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
      leading: backButtonBool ? BackButton(onPressed: ()=>{Navigator.pop(context)}): Container(),
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