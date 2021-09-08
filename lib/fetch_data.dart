import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FetchData{
  Future <List<dynamic>> fetchJournalList() async{
    var url = Uri.parse('https://byustudies.byu.edu/byu-app-connection/get_journal_list.php');
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
    /*Data Structure
    {
      [
        id
        post_title
        image_id
        image_url
      ]
    }
    */
    /*get data
      FetchData().fetchArticleDetails("37192").then((result) {
        var data = result[0][id];
      })
     */
  }

  Future <List<dynamic>> fetchArticleList(var journalId) async{
    // take journalId and get al articles associated with it.
    var url = Uri.parse('https://byustudies.byu.edu/byu-app-connection/get_article_list.php');
    http.Response response = await http.post(
      url,
      body:<String, String>{'journalId':journalId});
    //var data = jsonDecode(response.body);
    var data = jsonDecode(response.body);
    return data;
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
    }
   */
    /*get data
      FetchData().fetchArticleDetails("37192").then((result) {
        var data = result[0][id];
      })
    */
  }

  Future <dynamic> fetchArticleDetails(var articleId) async{
    //the app already has the title, subtitle and authors
    var url = Uri.parse('https://byustudies.byu.edu/byu-app-connection/get_article_details.php');
    http.Response response = await http.post(
        url,
        body:<String, String>{'articleId':articleId});
    var data = jsonDecode(response.body);
    return data;
    /*
    {
      content
    }
    */
    /*get data
      FetchData().fetchArticleDetails("37192").then((result) {
        var data = result['content'];
      })
    */
  }
}