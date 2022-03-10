import 'package:collection/src/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../firebase/FirebaseFunctions.dart';

class Home extends StatefulWidget{
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final Stream<QuerySnapshot> _pantryStream = FirebaseFirestore.instance.collection('Pantry').orderBy('experation').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PANTRY"),
          leading: Padding(padding: EdgeInsets.only(left:10.0,top: 10.0, bottom: 10.0),
          child:Image.asset("assets/images/logo.png", height: 100,
            width: 100,)),
          backgroundColor: Color(0xff7ED957),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/addFoods");
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              StreamBuilder<QuerySnapshot>(
                stream: _pantryStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return Expanded(child:ListView(
                    children: snapshot.data!.docs.mapIndexed((index, DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      DateTime today = new DateTime.now();
                      DateTime sevenDays = today.add(new Duration(days: 7));
                      DateTime date = (new DateTime.fromMicrosecondsSinceEpoch(data["experation"].microsecondsSinceEpoch));
                      var color = Colors.green;
                      if(date.isBefore(today)){
                        color = Colors.red;
                      }else if(date.isBefore(sevenDays)){
                        color = Colors.orange;
                      } else if(date.isAfter(sevenDays)){
                        color = Colors.green;
                      }else{
                        color = Colors.red;
                      }
                      int difference = date.difference(today).inDays;
                      final DateFormat formatter = DateFormat('MM/dd/yyyy');
                      final String formatted = formatter.format(date);
                      return Dismissible(
                        key: UniqueKey(),//ValueKey<int>(index),
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            if (direction == DismissDirection.startToEnd) {
                              FirebaseFunctions().addToShoppingList(name:data['name']);
                              FirebaseFunctions().deleteFromPantry(document.id);
                              print("Move to shopping List");
                            } else {
                              FirebaseFunctions().deleteFromPantry(document.id);
                              print('Remove item');
                            }
                            data.remove(index);
                            //
                          });
                        },
                        background: Container(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Icon(Icons.local_grocery_store, color: Colors.white),
                                Text('Shopping list', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Delete', style: TextStyle(color: Colors.white)),
                                Icon(Icons.delete, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        child:Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Text(
                                    data['name'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  difference<0 ? "Expired" : difference.toString()+" days",
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                    }).toList(),
                  )
                  );
                },
              ),
              //FloatingAction
            ]
        )
    );
  }
}