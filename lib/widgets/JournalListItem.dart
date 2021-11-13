import 'dart:convert';
import 'package:flutter/material.dart';

import '../fetch_data.dart';

class JournalListItem extends StatelessWidget implements PreferredSizeWidget{
  late final journal;
  JournalListItem(var journal){
    this.journal=journal;
  }
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: FittedBox(
        child: FutureBuilder(
          builder: ( context, projectSnap){
            if (projectSnap.connectionState == ConnectionState.waiting ) {
              return Center();
              //return Center(child: new CircularProgressIndicator());
            }
            final data = projectSnap.data;
            return Image.memory(base64Decode(data.toString()));
          },
          future: FetchData().getEncodedImage(journal.image_url),
        ),
        fit:BoxFit.fill),
        footer: GridTileBar(
          backgroundColor: Color(0xAA000000),
          title:Center(
            child: Text(
              journal.title,
              style: TextStyle( color: Colors.white ),
            ),
          ),
        )
    );
  }
  @override
  Size get preferredSize => throw UnimplementedError();
}