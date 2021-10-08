
import 'package:flutter/material.dart';

final String tableArticles = "articles";

class ArticleFields{
  static final String id = '_id';
  static final String title = 'title';
  static final String subtitle = 'subtitle';
  static final String type = 'type';
  static final String authorList = 'authorList';
  static final String articleJournal = 'articleJournal';
}

class LocalArticle {
  var id;
  var title;
  var subtitle;
  var type;
  var authorList;
  var articleJournal;

  LocalArticle({
    this.id,
    this.title,
    this.subtitle,
    this.type,
    this.authorList,
    this.articleJournal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'type': type,
      'authorList': authorList,
      'articleJournal': articleJournal,
    };
  }

  @override
  String toString() {
    return 'Article{id: $id, title: $title, subtitle: $subtitle, type: $type, articleJournal: $articleJournal}';
  }

  List<String> toList(){
    return [id.toString(),title,subtitle,type,authorList,articleJournal.toString()];
  }


}