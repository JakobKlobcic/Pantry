import 'package:byu_studies/fetch_data.dart';
import 'package:byu_studies/models/Author.dart';
import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/widgets/AuthorListItem.dart';
import 'package:flutter/material.dart';

class BrowseAuthors extends StatelessWidget {
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
              final data = projectSnap.data as List<Author>;
              return Scaffold(
                body:Padding(
                  padding: EdgeInsets.all(8.0),
                  child:ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      Author author = data[index];
                      //args.data=author;
                      return new InkResponse(
                        child:AuthorListItem(author),
                        onTap: ()=>{
                          mainNavKey.currentState!.pushNamed("/author_details", arguments: new Arguments(key: args.key, data: author))
                        },
                      );
                    },
                  )
                ),
              );
            },
            future: FetchData().fetchAuthorList(""),
          )
          )
        ]
      ),
    );
  }
}