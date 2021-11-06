import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/widgets/ArticleListItem.dart';
import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';

import '../models/Journal.dart';
import '../models/Article.dart';
import '../fetch_data.dart';

//todo: check article titled: "Dating the death of Jesus Christ" --> the table is to wide for the screen
class Articles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    Journal journal = args.data;
    return Scaffold(
      appBar: BaseAppBar(context,true,journal.title),
      body:Column(
        children:[
          Text(journal.title),
          Divider(
            height: 10,
            thickness: 3,
            indent: 15,
            endIndent: 15,
          ),
          Expanded(child:
            FutureBuilder(
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.waiting ) {
                  return Center(child: new CircularProgressIndicator());
                }
                final data = projectSnap.data as List<Article>;
                return Scaffold(
                  body:Padding(
                    padding: EdgeInsets.all(8.0),
                    child:ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Article article = data[index];
                        return new InkResponse(
                          child:ArticleListItem(article, true),
                          onTap: ()=>{
                            print(article.title),
                            Navigator.pushNamed(context, "/article_detail", arguments:new Arguments(data:article))
                          },
                        );
                      },
                    )
                  ),
                );
              },
              future: FetchData().fetchArticleList(journal.id),
            )
          )
        ]
      )
    );
  }
}