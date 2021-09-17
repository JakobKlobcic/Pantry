import 'package:flutter/material.dart';

class ArticleDetail extends StatelessWidget {
  var article;
  ArticleDetail(data){
    this.article=data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Text("Article detail"));
  }

}