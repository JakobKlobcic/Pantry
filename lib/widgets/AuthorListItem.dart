import 'package:flutter/material.dart';

class AuthorListItem extends StatelessWidget implements PreferredSizeWidget{
  late final author;
  AuthorListItem(var author){
    this.author=author;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Text(author.name),
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