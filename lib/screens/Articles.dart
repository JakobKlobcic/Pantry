import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/widgets/ArticleListItem.dart';
import 'package:flutter/material.dart';
import 'package:byu_studies/Widgets/BaseAppBar.dart';
import 'package:grouped_list/grouped_list.dart';

import '../models/Journal.dart';
import '../models/Article.dart';
import '../fetch_data.dart';

//todo: check article titled: "Dating the death of Jesus Christ" --> the table is to wide for the screen
class Articles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    Journal journal = args.data;
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
                //TODO: See if there is a way to get the list dynamically
                List<String> list= [
                  "Introduction",
                  "Conference Proceeding",
                  "Article",
                  "Document",
                  "Essay",
                  "Photo Essay",
                  "Creative Art",
                  "Cover Image",
                  "Poem",
                  "Review",
                  "Book Notice",
                  "Notes and Comments",
                  "Bibliography",
                  "Index"
                ];
                if (projectSnap.connectionState == ConnectionState.waiting ) {
                  return Center(child: new CircularProgressIndicator());
                }
                final data = projectSnap.data as List<Article>;
                return Scaffold(
                  body:Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GroupedListView<Article, String>(
                      elements: data,
                      groupBy: (Article article) => article.type,
                      groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
                      groupComparator: (value1, value2){
                        var val1Index = list.indexOf(value1);
                        var val2Index = list.indexOf(value2);
                        return val1Index.compareTo(val2Index);
                      },
                      itemBuilder: (context, article) {
                        return new InkResponse(
                          child:ArticleListItem(article, true),
                          onTap: ()=>{
                            Navigator.pushNamed(context, "/article_detail", arguments:new Arguments(data:article))
                          },
                        );
                      },
                      //useStickyGroupSeparators: true, // optional
                      //floatingHeader: true, // optional
                      order: GroupedListOrder.ASC, // optional
                    ),
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
}