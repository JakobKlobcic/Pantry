import 'package:byu_studies/models/RouteArguments.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/list_extensions.dart';

import '../firebase/FirebaseFunctions.dart';
import '../models/Recepie.dart';

class Recepies extends StatefulWidget{
  @override
  _Recepies createState() => _Recepies();
}

class _Recepies extends State<Recepies>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recepies"),
        backgroundColor: Color(0xff7ED957),
        leading: Padding(padding: EdgeInsets.only(left:10.0,top: 10.0, bottom: 10.0),
            child:Image.asset("assets/images/logo.png", height: 100,
              width: 100,)),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.waiting ) {
            return Center(child: new CircularProgressIndicator());
          }
          var data = projectSnap.data as List<Recepie>;
          data.sort((a, b) => (b.count).compareTo(a.count));
          //data.forEach((element) { })
          return Scaffold(
            body:Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var result = data[index];
                  return new InkResponse(
                    child:ListTile(
                      title: Text(result.name),
                      subtitle: Text(result.count.toString()+"/"+result.ingredients.length.toString()+ " ingredients"),
                    ),
                    onTap: (){
                      //Navigator.pushNamed(context, "/recepieDetails", arguments:new Arguments(data:result));
                    },
                  );
                },
              ),
            ),
          );
        },
        future: FirebaseFunctions().getOrderedRecepies(),
      ),
    );
  }

}