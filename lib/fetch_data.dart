import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/Journal.dart';
import 'models/Article.dart';
import 'models/Author.dart';
import 'models/SearchResult.dart';

//journal:44526
//article:37192
class FetchData {
  Future<List<Journal>> fetchJournalList() async {
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_journal_list.php');
    http.Response response = await http.get(url);
    List<Journal> journals = [];
    try {
      var data = jsonDecode(response.body);


      data.forEach((singleJournal) =>{
        journals.add(new Journal(
            id: singleJournal["id"],
            title: singleJournal["title"],
            image_id: singleJournal["image_id"],
            image_url: singleJournal["image_url"]))
      });
    }on SocketException{
      print('No Internet connection');
    }on TimeoutException {
      print("the request is taking too long");
    }on Exception catch(e){
      print(e);
    }

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

  Future<String> fetchArticleContent(var articleId) async {
    //the app already has the title, subtitle and authors
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_article_details.php');
    http.Response response =
        await http.post(url, body: <String, String>{'articleId': articleId});
    var data = jsonDecode(response.body);
    return data["content"];
    /*
    {
      content
    }
    */
  }

  Future<List<SearchResult>> fetchSearchResults(String searchEntry) async {
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_search_results_list.php');
    http.Response response =
      await http.post(url, body: <String, String>{'searchString': searchEntry});
    var data = jsonDecode(response.body);
    List<SearchResult> results = [];
    data.forEach((singleResult)=>{
      results.add(new SearchResult(
          id: singleResult["id"],
          title: singleResult["title"],
          type: singleResult["type"]
        )
      )
    });
    return results;
    /*
    {
      [
        id
        title
        type
      ]
    }
    */
  }

  Future<Article> fetchSingleArticle(String articleId) async {
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_single_article.php');
    http.Response response =await http.post(url, body: <String, String>{'articleId': articleId});
    var data = jsonDecode(response.body);
    Article article;/*
    List<Author> authors = [];
    data["authors"].forEach((author) {
      authors.add(new Author(
          id: author["id"],
          name: author["name"]
      ));
    }
    );*/
    article = (new Article(
      id: data["id"],
      type: data["type"],
      title: data["title"],
      subtitle: data["subtitle"],
      authorList: data["authors"],
    ));
    return article;
  }

  Future<Author> fetchAuthorDetails(String authorId) async {
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_single_author.php');
    http.Response response =await http.post(url, body: <String, String>{'authorId': authorId});
    var data = jsonDecode(response.body);
    //print(data);
    List<Article> articles=[];
    data["articles"].forEach((article){
      Article theArticle =new Article(
        id: article["id"],
        type: article["type"],
        title: article["title"],
        subtitle: article["subtitle"],
        authorList: article["authors"],
      );
      articles.add(theArticle);

    });
    Author author=new Author(
      id: data["id"],
      name: data["name"],
      image_url: data["image_url"],
      articles: articles,
    );
    return author;
  }

  Future<Journal> fetchSingleJournal(var journalId) async {
    print("fetching journal");
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_single_journal.php');
    http.Response response = await http.post(url, body: <String, String>{'journalId': journalId});
    var data = jsonDecode(response.body);
    Journal journal= new Journal(
      id: data["id"],
      title: data["title"],
      image_id: data["image_id"],
      image_url: data["image_url"]
    );
    return journal;
    /*Data Structure
    {
        id
        title
        image_id
        image_url
    }
    */
  }
}
