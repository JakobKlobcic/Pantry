import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/models/Tag.dart';
import 'package:byu_studies/widgets/ArticleListItem.dart';
import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';

import '../models/Article.dart';
import '../fetch_data.dart';

class TagDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Arguments;
    Tag tag = args.data as Tag;
    var mainNavKey = args.key;
    return Scaffold(
      appBar: BaseAppBar(context,true,tag.name),
      body:FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting ) {
            return Center(child: new CircularProgressIndicator());
          }
          final articles = projectSnap.data as List<Article>;
          //final articles = data.articles as List<Article>;
          return
            Column(children:[
              Container(
                color: Colors.white,
                child:
                Column(children:[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Row(
                      children: [
                        Text(tag.name),
                      ],
                    )
                  ),
                  Divider(
                    height: 10,
                    thickness: 3,
                    indent: 15,
                    endIndent: 15,
                  ),
                ]
                ),
              ),
              Expanded(child:
              Padding(
                padding: EdgeInsets.all(8.0),
                child: articles.length == 0 ? Text("There are no articles from this author.") : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    Article article = articles[index];
                    return new InkResponse(
                      child:ArticleListItem(article,true),
                      onTap: (){
                        print(Navigator.of(context, rootNavigator: true).toString());
                        mainNavKey.currentState!.pushNamed("/article_detail", arguments: Arguments(data:article));
                      },
                    );},
                )
              )
              ),
            ]);
        },
        future: FetchData().fetchTagArticles(tag.id),
      )
    );
  }
}