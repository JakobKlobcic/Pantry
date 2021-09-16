import 'Author.dart';
class Article {
  String id;
  String title;
  String subtitle;
  String type;
  List<Author> authorList;

  Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.authorList,
  });


}