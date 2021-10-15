import 'package:flutter/material.dart';

class Article {
  var id;
  var title;
  var subtitle;
  var type;
  var authorList;
  var articleJournal;
  var content;

  Article({
    this.id,
    this.title,
    this.subtitle,
    this.type,
    this.authorList,
    this.articleJournal,
    this.content
  });

  void printArticle(){
    print('id:$id,\ntitle: $title,\nsubtitle: $subtitle,\ntype: $type,\nauthorList: $authorList,\narticleJournal: $articleJournal,\ncontent: $content');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'type': type,
      'authorList': authorList,
      'articleJournal': articleJournal,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Article{id: $id, title: $title, subtitle: $subtitle, type: $type, articleJournal: $articleJournal, content:$content}';
  }

  List<String> toList(){
    return [id.toString(),title,subtitle,type,authorList,articleJournal.toString(), content];
  }
}