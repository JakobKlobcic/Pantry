import 'package:flutter/material.dart';
import '../models/Article.dart';

class ArticleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Article article = ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(body:Text(article.title));
  }

}