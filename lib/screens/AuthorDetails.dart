import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/widgets/ArticleListItem.dart';
import 'package:byu_studies/widgets/CustomNetworkImage.dart';
import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';

import '../models/Author.dart';
import '../models/Article.dart';
import '../fetch_data.dart';

class AuthorDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    Author author = args.data as Author;
    return Scaffold(
      appBar: BaseAppBar(context,true,author.name),
      body:FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting ) {
            return Center(child: new CircularProgressIndicator());
          }
          final data = projectSnap.data as Author;
          List<Article> articleList = data.articles as List<Article>;
          print(articleList);
          /*List<Article> articleList = [];
          if(author.articles.length<=0){
            articleList=articles;
          }*/
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
                            child:CustomNetworkImage(author.image_url),//data.image_url == "" ? Image(image:AssetImage("assets/images/default_user.png")) : Image(image: NetworkImage(data.image_url.toString())),
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
              Expanded(
              child:/*FutureBuilder(
                builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.waiting) {
                  return Center(child: new CircularProgressIndicator());
                }
                List<Article> articleList = author.articles;
                if(articleList.length<=0){
                  articleList=data;
                }else{
                  articleContent=author.articles;
                }*/
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: articleList.length == 0 ? Text("There are no articles from this author.") : ListView.builder(

                    itemCount: articleList.length,
                    itemBuilder: (context, index) {
                      Article article = articleList[index];
                      return new InkResponse(
                        child:ArticleListItem(article,true),
                        onTap: ()=>{
                          args.key.currentState!.pushNamed("/article_detail", arguments: new Arguments(data:article))
                        },
                      );
                    },
                  )
                )
                /*}*/),
            ]);
          },
          future: FetchData().fetchAuthorDetails(author.id),
        )
      );
  }
}