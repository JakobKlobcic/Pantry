import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/list_extensions.dart';

import '../firebase/FirebaseFunctions.dart';

class ShoppingList extends StatefulWidget{
  @override
  _ShoppingList createState() => _ShoppingList();
}

class _ShoppingList extends State<ShoppingList>{
  var isChecked=false;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _shoppingListStream = FirebaseFirestore.instance.collection('ShoppingList').orderBy("bought").snapshots();
    return Scaffold(
     appBar: AppBar(
       title: Text("Shopping List"),
       leading: Padding(padding: EdgeInsets.only(left:10.0,top: 10.0, bottom: 10.0),
           child:Image.asset("assets/images/logo.png", height: 100,
             width: 100,)),
       backgroundColor: Color(0xff7ED957),
       automaticallyImplyLeading: false,
     ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addToCart");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            StreamBuilder<QuerySnapshot>(
              stream: _shoppingListStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Expanded(child:ListView(
                  children: snapshot.data!.docs.mapIndexed((index, DocumentSnapshot document) {
                    print(document.id);
                    print(index);
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Dismissible(
                      key: UniqueKey(),//ValueKey<int>(index),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                            FirebaseFunctions().deleteFromShoppingList(document.id);
                          data.remove(index);
                          //
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              Text('Delete', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              Text('delete', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      child:Container(
                        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(children: [
                          Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: data["bought"],
                          onChanged: (bool? value) {
                            setState(() {
                              FirebaseFunctions().checkBought(document.id, value);
                            });
                          },
                        ),
                        Text(
                          data['name'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ))
                        ],),/*ListTile(
                          title: Text(
                            data['name'],
                            style: TextStyle(
                              fontSize: 15
                              ,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),*/
                      )
                    );
                  }).toList(),
                )
                );
              },
            ),
            //FloatingAction
          ]
      ),
   );
  }
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
}