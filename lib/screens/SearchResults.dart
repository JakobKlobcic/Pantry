import 'package:flutter/material.dart';
import '../fetch_data.dart';
import '../models/SearchResult.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/Article.dart';

class SearchResults extends StatefulWidget{
  @override
  _SearchResults createState() => _SearchResults();
}
//TODO: add article journal to article item;
class _SearchResults extends State<SearchResults> {
  String enteredSearch ="";
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: ()=>{Navigator.pop(context)},),
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
              child: TextField(
                autofocus: true,
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
              ),
            ),
          )
      ),
      body: Column(
        children:[
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 15.0, left: 15.0, right: 15.0),
            child:Text("Search results:"),
          ),
          Divider(
            height: 10,
            thickness: 3,
            indent: 15,
            endIndent: 15,
          ),
          Expanded(child:enteredSearch==""? Text (""):
            FutureBuilder(
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.waiting ) {
                  return new Center(child: new CircularProgressIndicator());
                }
                final data = projectSnap.data as List<SearchResult>;
                return Scaffold(
                  body:Padding(
                    padding: EdgeInsets.all(8.0),
                    child:data.length==0? Text("No results found."):ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        SearchResult result = data[index];
                        return new InkResponse(
                          child:searchResultItem(result),
                          onTap: (){
                            if(result.type=="article"){
                              FetchData().fetchSingleArticle(result.id).then((returnedArticle) {
                                Navigator.pushNamed(context, "/article_detail", arguments:returnedArticle);
                              });
                            }else if(result.type=="author"){
                              FetchData().fetchAuthorDetails(result.id).then((returnedAuthor) {
                                Navigator.pushNamed(context, "/author_details", arguments:returnedAuthor);
                              });
                            }else if(result.type=="journal"){
                              FetchData().fetchSingleJournal(result.id).then((returnedJournal) {
                                Navigator.pushNamed(context, "/articles", arguments:returnedJournal);
                              });
                            }
                          },
                        );
                      },
                    )
                  ),
                );
              },
              future: FetchData().fetchSearchResults(enteredSearch),
            )
          )
        ]
      )
    );
  }
  Widget searchResultItem(SearchResult result){
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);//Capitalizes first letter of type
    return Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Html(data:result.title),
          subtitle: Html(data:capitalize(result.type.toString())),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 0.5),
              borderRadius: BorderRadius.circular(5.0)
          ),
        )
    );
  }
}
