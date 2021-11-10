import 'package:byu_studies/database/Database.dart';
import 'package:byu_studies/models/Article.dart';
import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/widgets/ArticleListItem.dart';
import 'package:flutter/material.dart';

class BrowseDownloaded extends StatefulWidget{
  @override
  _BrowseDownloaded createState() => _BrowseDownloaded();
}

class _BrowseDownloaded extends State<BrowseDownloaded> {
  var enteredSearch ="";
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mainNavKey;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
      mainNavKey = args.key;
    }
    return Scaffold(
      body: Column(children: [
        TextField(
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
                if(_controller.text!="") {
                  setState(() {
                    _controller.text = "";
                    enteredSearch = "";
                  });
                }
              },
            ),
            hintText: 'Search...',
            border: InputBorder.none
          ),
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
                        child:ArticleListItem(article, false),
                        onTap: (){
                          mainNavKey.currentState!.pushNamed("/article_detail", arguments: new Arguments(data:article));
                        },
                      );
                    },
                  )
                ),
              );
            },
            future: DBProvider.db.getArticle(enteredSearch),
          )
        )
      ],
      )
    );
  }
}