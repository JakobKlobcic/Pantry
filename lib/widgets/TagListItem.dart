import 'package:flutter/material.dart';

class TagListItem extends StatelessWidget implements PreferredSizeWidget{
  var tag;
  TagListItem(var tag){
    this.tag=tag;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Text(tag.name),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 0.5),
              borderRadius: BorderRadius.circular(5.0)
          ),
        )
    );
  }
  @override
  Size get preferredSize => throw UnimplementedError();



}