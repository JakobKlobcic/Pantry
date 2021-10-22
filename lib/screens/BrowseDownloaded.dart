import 'package:byu_studies/database/Database.dart';
import 'package:byu_studies/models/Article.dart';
import 'package:byu_studies/widgets/ArticleListItem.dart';
import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';

class BrowseDownloaded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        /*TextField(
              onChanged: (text){
                setState(() {
                  enteredSearch = text;
                });
              },
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _controller.text="";
                      enteredSearch ="";
                    });
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none
              ),
            ),*/
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
                        child:ArticleListItem(article, false),
                        onTap: (){
                          Navigator.of(context, rootNavigator: true).pushNamed("/article_detail", arguments:article);
                        },
                      );
                    },
                  )
                ),
              );
            },
            future: DBProvider.db.getArticle(),
          )
        )
      ],
      )
    );
  }
}