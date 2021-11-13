import 'package:byu_studies/Widgets/BaseAppBar.dart';
import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/widgets/JournalListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../fetch_data.dart';
import '../models/Journal.dart';


class Journals extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return(
        Scaffold(
          appBar: BaseAppBar(context,false,"Journal"),
          body:journalListWidget()
        )
    );
  }
  Widget journalListWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.waiting ) {
          return new Center(child: new CircularProgressIndicator());
        }
        final data = projectSnap.data as List<Journal>;

        return Scaffold(
            body:OrientationBuilder(
              builder: (context, orientation){
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.0, top: 20.0, left: 15.0, right: 15.0),
                  child:
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 15,
                          childAspectRatio: 2/3
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Journal journal = data[index];
                        return new InkResponse(
                          child:JournalListItem(journal),
                          onTap: ()=>{onItemTap(context, journal)},);
                      },
                    )
                );
              },
            ),
          );
      },
      future: FetchData().fetchJournalList(),
    );
  }

  void onItemTap(context, journal){
    Navigator.pushNamed(context, "/articles", arguments: Arguments(data:journal)); // with navigation
  }
}