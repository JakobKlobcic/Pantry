import 'package:byu_studies/database/Database.dart';
import 'package:byu_studies/models/Article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../fetch_data.dart';

//import 'package:flutter_html/flutter_html.dart';

class ArticleListItem extends StatelessWidget implements PreferredSizeWidget{
  late final article;
  late final download;
  ArticleListItem(var article, var download){
    this.article=article;
    this.download=download;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: ListTile(
        title: Html(data: article.title),
        subtitle: Html(
            data: article.subtitle != null ? article.subtitle : ""
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 0.5),
            borderRadius: BorderRadius.circular(5.0)
        ),
        trailing: !download ? null :PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) =>
          [
            PopupMenuItem(
              child: Row(
                children: <Widget>[
                  Icon(Icons.download),
                  Text("Make available Offline"),
                ],
              ),

              value: 1,
            ),
          ],
          onSelected: (selectedValue) {
            if (selectedValue == 1) {
              article.printArticle();
              FetchData().fetchArticleContent(article.id).then((result) {
                String authors = "";
                article.authorList.forEach((author) {
                  authors += author.name;
                });
                Article dbArticle = new Article(
                  id: article.id,
                  title: article.title,
                  subtitle: article.subtitle != null ? article.subtitle : "",
                  type: article.type,
                  authorList: authors,
                  articleJournal: article.articleJournal,
                  content: result,
                );
                DBProvider.db.newArticle(dbArticle);
              });
            }
          },
        ),
      )
    );
  }
  @override
  Size get preferredSize => throw UnimplementedError();



}