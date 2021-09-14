import 'package:flutter/material.dart';
import '../fetch_data.dart';
import '../models/BasicJournal.dart';


class Journals extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return(
        Scaffold(
          body:journalListWidget()
        )
    );
  }
  Widget journalListWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        final data = nullCheck(projectSnap.data as List<BasicJournal>);
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container();
        }
        return Scaffold(
            body:OrientationBuilder(
              builder: (context, orientation){
                return Padding(padding: EdgeInsets.only(bottom: 20.0, top: 20.0, left: 15.0, right: 15.0),child:GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 15, childAspectRatio: 2/3
                  ),
                  itemCount: data.length,

                 // padding: const EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    BasicJournal journal = data[index];
                    return new InkResponse(child:listItem(journal), onTap: ()=>{onItemTap(journal)},);
                  },
                ));
              },
            ),
          );
      },
      future: FetchData().fetchJournalList(),
    );
  }

  Widget listItem(BasicJournal journal){
    return GridTile(
      child: FittedBox(
          child:Image.network(journal.image_url),
          fit:BoxFit.fill),
      footer: GridTileBar(
        backgroundColor: Color(0xAA000000),
        title:Center( child: Text(journal.title, style: TextStyle(color: Colors.white),),),
      ),
    );
  }

  void onItemTap(journal){
    print(journal.title);
  }

  List<dynamic> nullCheck(Object list){
    if (list is List) {
      if(list.isEmpty){
        return [];
      }
      return list;
    }
    return [];
  }
}