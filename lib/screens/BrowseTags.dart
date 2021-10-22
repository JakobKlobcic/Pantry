import 'package:byu_studies/models/Tag.dart';
import 'package:byu_studies/widgets/TagListItem.dart';
import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';

import '../fetch_data.dart';

class BrowseTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children:[
              Expanded(child:
              FutureBuilder(
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.waiting ) {
                    return Center(child: new CircularProgressIndicator());
                  }
                  final data = projectSnap.data as List<Tag>;
                  return Scaffold(
                    body:Padding(
                        padding: EdgeInsets.all(8.0),
                        child:ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            Tag tag = data[index];
                            return new InkResponse(
                              child:TagListItem(tag),
                              onTap: ()=>{
                                Navigator.pushNamed(context, '/browse/tag_details', arguments:tag)
                              },
                            );
                          },
                        )
                    ),
                  );
                },
                future: FetchData().fetchTags(""),
              )
              )
            ]
        ),
    );
  }
}