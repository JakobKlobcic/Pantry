import 'package:byu_studies/Widgets/BaseAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

import '../fetch_data.dart';
import '../models/Article.dart';

class ArticleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Article article = ModalRoute
        .of(context)!
        .settings
        .arguments as Article;

    return Scaffold(
      appBar: BaseAppBar(context,true,article.title),
      body: Padding(
        padding: EdgeInsets.only(bottom: 2.0, top: 2.0, left: 15.0, right: 15.0),
        child:Column(
          children: [
            Expanded(
              flex: 1,
              child:FutureBuilder(
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.waiting) {
                    return Container(/*Add a progress indicator of some kind*/);
                  }
                  String data = projectSnap.data.toString();
                  String articleContent;
                  if(article.content==null || article.content.isEmpty || article.content==""){
                    articleContent=data;
                  }else{
                    articleContent=article.content;
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:Column(
                      children: [
                        Html(data:article.title),
                        Html(
                          data:articleContent,
                          onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                            //open URL in webview, or launch URL in browser, or any other logic here
                          }
                        ),
                      ],
                    ),
                  );
                },
                future: FetchData().fetchArticleContent(article.id),
              )
            )
          ],
        )
      )
    );
  }
}