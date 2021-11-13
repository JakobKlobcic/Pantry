import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/Journal.dart';
import 'models/Article.dart';
import 'models/Author.dart';
import 'models/SearchResult.dart';
import 'models/Tag.dart';

//journal:44526
//article:37192
class FetchData {

  //Journal---------------------------------------------------------------------
  Future<List<Journal>> fetchJournalList() async {
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_journal_list.php');
    http.Response response = await http.get(url);
    List<Journal> journals = [];
    try {
      var data = jsonDecode(response.body);
      //print(data);

      data.forEach((singleJournal) =>{
        journals.add(new Journal(
            id: singleJournal["id"],
            title: singleJournal["title"],
            image_id: singleJournal["image_id"],
            image_url: singleJournal["image_url"],))
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

  Future<Journal> fetchSingleJournal(var journalId) async {
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

  //Article---------------------------------------------------------------------
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
          articleJournal: singleArticle['articleJournal']
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
        articleJournal: data['articleJournal']

    ));
    return article;
  }

  //Tag-------------------------------------------------------------------------
  Future<List<Tag>> fetchTagList(String searchEntry) async{
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_tags_list.php');
    http.Response response = await http.post(url, body: <String, String>{'searchString': searchEntry});
    var data = jsonDecode(response.body);
    List<Tag> tagList =[];
    data.forEach((tag){
      tagList.add(new Tag(
          id:tag["id"],
          name:tag["name"]
      ));
    });
    return tagList;
  }

  Future<List<Article>> fetchTagArticles(String tagId) async{
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_tag_articles.php');
    http.Response response = await http.post(url, body: <String, String>{'tagId': tagId});
    var data = jsonDecode(response.body);
    List<Article> tagArticleList =[];
    data.forEach((article){
      tagArticleList.add(new Article(
          id: article["id"],
          type: article["type"],
          title: article["title"],
          subtitle: article["subtitle"],
          authorList: article["authors"],
          articleJournal: article['articleJournal']
      ));
    });
    return tagArticleList;
  }

  //Search Result---------------------------------------------------------------
  Future<List<SearchResult>> fetchSearchResultsList(String searchEntry) async {
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

  //Author----------------------------------------------------------------------
  Future<List<Author>> fetchAuthorList(var searchString) async{
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_authors_list.php');
    http.Response response =
    await http.post(url, body: <String, String>{'searchString': searchString});
    var data = jsonDecode(response.body);

    List<Author> authorList = [];
    data.forEach((author){
      authorList.add(new Author(
          id: author["id"],
          name: author["name"],
          image_url: author["image_url"]
      ));
    });

    return authorList;
  }

  Future<Author> fetchAuthorDetails(String authorId) async {
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_single_author.php');
    http.Response response =await http.post(url, body: <String, String>{'authorId': authorId});
    var data = jsonDecode(response.body);
    //print(data);
    List<Article> articles=[];
    data["articles"].forEach((article){
      if(article["title"]!=null) {
        articles.add(new Article(
            id: article["id"],
            type: article["type"],
            title: article["title"],
            subtitle: article["subtitle"],
            authorList: article["authors"],
            articleJournal: article['articleJournal']
        ));
      }
    });
    Author author=new Author(
      id: data["id"],
      name: data["name"],
      image_url: data["image_url"],
      articles: articles,
    );
    return author;
  }

  //image
  Future <String> getEncodedImage(var imageUrl) async{
    var url = Uri.parse(
        'https://byustudies.byu.edu/byu-app-connection/get_image.php');
    http.Response response =await http.post(url, body: <String, String>{'imageUrl': imageUrl});
    var data = jsonDecode(response.body);
    return data["encoded_image"];
  }

}
