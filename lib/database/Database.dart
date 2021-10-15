import 'dart:async';
import 'package:byu_studies/models/Article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider{
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future <Database> get database async{
    if(_database != null){
      return _database!;
    }

    _database = await initDB();
    return _database!;
  }

  initDB() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'local_database.db'),
      onCreate: (db, version) async{

        await db.execute(
          '''
          CREATE TABLE articles (
            id INTEGER PRIMARY KEY, 
            title TEXT,
            subtitle TEXT,
            type TEXT,
            authorList TEXT,
            articleJournal INTEGER,
            content TEXT
          )
          '''
        );
      },
      version: 1,
    );
  }



  newArticle(Article article) async{
    final db =await database;

    var res = await db.rawInsert(
      '''
      INSERT INTO articles(
        id, title, subtitle, type, authorList, articleJournal, content
      )values(?,?,?,?,?,?,?)
      ''',
      article.toList()
    );
    print(res);
    return res;
  }

  deleteArticle(var id)async{
    final db = await database;
    var res = await db.rawDelete('DELETE FROM articles WHERE id ='+id.toString());
    print(res);
  }

  Future <List<Article>> getArticle() async{
    final db = await database;
    var res = await db.query('articles');
    List<Article> articles =[];
    if(res.length==0){
      return articles;
    }else{
      res.forEach((article)=>{
        articles.add(new Article(
          id: article["id"],
          title: article["title"],
          subtitle: article["subtitle"],
          type: article["type"],
          authorList: article["authorList"],
          articleJournal: article["articleJournal"],
          content: article["content"]
        ))
      });
      return articles;
    }

  }
}

/*
TODO: figure out how to use foreign keys and create an extra array fro author articles and add that array to authorList

 */