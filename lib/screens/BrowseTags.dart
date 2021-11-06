import 'package:byu_studies/fetch_data.dart';
import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/models/Tag.dart';
import 'package:byu_studies/widgets/TagListItem.dart';
import 'package:flutter/material.dart';

class BrowseTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    var mainNavKey=args.key;
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
                                args.key.currentState!.pushNamed('/tag_details', arguments:new Arguments(key:mainNavKey, data:tag))
                              },
                            );
                          },
                        )
                    ),
                  );
                },
                future: FetchData().fetchTagList(""),
              )
              )
            ]
        ),
    );
  }
}