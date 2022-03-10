import 'package:byu_studies/models/RouteArguments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../firebase/FirebaseFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Recepie.dart';

class RecepieDetails extends StatefulWidget{
  @override
  _RecepieDetails createState() => _RecepieDetails();
}

class _RecepieDetails extends State<RecepieDetails>{

  final TextEditingController foodNameController = new TextEditingController();
  final TextEditingController experationDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    Recepie recepie = args.data;
    return Scaffold(
        appBar: AppBar(
          title: Text("Add to Pantry"),
          backgroundColor: Color(0xff7ED957),
          leading: Padding(padding: EdgeInsets.only(left:10.0,top: 10.0, bottom: 10.0),
              child:Image.asset("assets/images/logo.png", height: 100,
                width: 100,)),
          automaticallyImplyLeading: false,
        ),
        body:Column(
          children:[
            FutureBuilder(
              builder: (context, projectSnap) {
                if (projectSnap.connectionState == ConnectionState.waiting ) {
                  return new Center(child: new CircularProgressIndicator());
                }
                final data = projectSnap.data as Recepie;
                print(data.ingredients);
                return Scaffold(
                  body:Padding(
                      padding: EdgeInsets.all(8.0),
                      child:ListView.builder(
                        itemCount: data.ingredients.length,
                        itemBuilder: (context, index) {
                          var result = data.ingredients[index];
                          return new InkResponse(
                            child:Text(result),
                            onTap: (){

                            },
                          );
                        },
                      )
                  ),
                );
              },
              future: FirebaseFunctions().getRecipie(recepie.id),
            )
          ]
        )
    );
  }
}