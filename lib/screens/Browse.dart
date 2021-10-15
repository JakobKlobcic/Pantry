import 'package:byu_studies/database/Database.dart';
import 'package:byu_studies/models/Article.dart';
import 'package:byu_studies/widgets/ArticleListItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Browse extends StatefulWidget{
  @override
  _Browse createState() => _Browse();
}
class _Browse extends State<Browse> {
  String enteredSearch ="";
  //final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(child:Text("Downloaded\n articles")),
              Tab(child:Text("Tags")),
              Tab(child:Text("Authors")),
            ],
          ),
          title: const Text('Browse'),
          leading: Container(),
        ),
        body: TabBarView(
          children: [
            Column(children: [
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
                future: DBProvider.db.getArticle(),
              )
              )
            ],
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
