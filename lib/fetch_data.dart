import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/Journal.dart';
import 'models/Article.dart';
import 'models/Author.dart';


class FetchData {
  Future<List<Journal>> fetchJournalList() async {
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_journal_list.php');
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);

    List<Journal> journals = [];
    data.forEach((singleJournal)=>{
      journals.add(new Journal(
          id: singleJournal["id"],
          title: singleJournal["title"],
          image_id: singleJournal["image_id"],
          image_url: singleJournal["image_url"]))
    });

    return journals;
    /*Data Structure
    {
      [
        id
        title
        image_id
        image_url
      ]
    }
    */
    /*get data with this code
      FetchData().fetchArticleDetails("37192").then((result) {
        var data = result[0][id];
      })
     */
  }

  Future<List<Article>> fetchArticleList(var journalId) async {
    // take journalId and get al articles associated with it.
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_article_list.php');
    http.Response response =
        await http.post(url, body: <String, String>{'journalId': journalId});
    var data = jsonDecode(response.body);
    //var data = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Article> articles = [];
    List<Author> authors = [];
    data.forEach((singleArticle)=>{
      //print(singleArticle["title"]);
      authors = [],
      singleArticle["authors"].forEach((author){
        authors.add(
            new Author(
                id: author["id"],
                name: author["name"]
            )
        );
      }
      ),
      articles.add(new Article(
          id: singleArticle["id"],
          type: singleArticle["type"],
          title: singleArticle["title"],
          subtitle: singleArticle["subtitle"],
          authorList: authors,
      )),
    });
    return articles;
    /*Data Structure
    {
      [
        id
        title
        subtitle
        type
        authors:[
          id
          name
        ]
      ]
    }*/
  }

  Future<dynamic> fetchArticleContent(var articleId) async {
    //the app already has the title, subtitle and authors
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_article_details.php');
    http.Response response =
        await http.post(url, body: <String, String>{'articleId': articleId});
    var data = jsonDecode(response.body);
    return data;
    /*
    {
      content
    }
    */
    /*gget data with this code
      FetchData().fetchArticleDetails("37192").then((result) {
        var data = result['content'];
      })
    */ //Look at design
  }
}
