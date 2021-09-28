import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/Journal.dart';
import '../models/Article.dart';
import '../fetch_data.dart';

//todo: check article titled: "Dating the death of Jesus Christ" --> the table is to wide for the screen
class Articles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Journal journal = ModalRoute.of(context)!.settings.arguments as Journal;
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
                  return Container(/*Add a progress indicator of some kind*/);
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
                          child:articleListItem(article),
                          onTap: ()=>{
                            print(article.title),
                            Navigator.pushNamed(context, "/article_detail", arguments:article)
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
  Widget articleListItem(Article article){
    return Padding(
      padding: EdgeInsets.all(5),
      child: ListTile(
        title: Html(data:article.title),
        subtitle: Html(data:article.subtitle != null ? article.subtitle:""),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 0.5),
            borderRadius: BorderRadius.circular(5.0)
        ),
      )
    );
  }
}