import 'package:byu_studies/widgets/ArticleListItem.dart';
import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/Author.dart';
import '../models/Article.dart';
import '../fetch_data.dart';

class AuthorDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Author author = ModalRoute.of(context)!.settings.arguments as Author;
    return Scaffold(
      appBar: BaseAppBar(context,true,author.name),
      body:FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting ) {
            return Container(/*Add a progress indicator of some kind*/);
          }
          final data = projectSnap.data as Author;
          final articles = data.articles as List<Article>;
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
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            child:data.image_url == "" ? Image(image:AssetImage("images/default_user.png")) : Image(image: NetworkImage(data.image_url.toString())),
                            width: 150,
                            height: 150,
                          )
                        ),
                        Text(author.name),
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
                        onTap: ()=>{
                          print(article.title),
                          Navigator.pushNamed(context, "/article_detail", arguments:article)
                        },
                      );},
                  )
              )
              ),
            ]);
          },
          future: FetchData().fetchAuthorDetails(author.id),
        )
      );
  }
}