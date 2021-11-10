import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget implements PreferredSizeWidget{
  late final url;
  CustomNetworkImage(var url){
    this.url=url;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child:(url==null || url == "") ? Image(image:AssetImage("assets/images/default_user.png")) : Image(image: NetworkImage(url.toString())),
          width: 150,
          height: 150,
        )
    );
  }
  @override
  Size get preferredSize => throw UnimplementedError();



}