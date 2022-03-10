import 'package:flutter/material.dart';
import '../firebase/FirebaseFunctions.dart';


class AddToCart extends StatefulWidget{
  @override
  _AddToCart createState() => _AddToCart();
}

class _AddToCart extends State<AddToCart>{

  final TextEditingController foodNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add to Pantry"),
          leading: Padding(padding: EdgeInsets.only(left:10.0,top: 10.0, bottom: 10.0),
              child:Image.asset("assets/images/logo.png", height: 100,
                width: 100,)),
          backgroundColor: Color(0xff7ED957),
          automaticallyImplyLeading: false,
        ),
        body:Column(children:[
          //Text("Food:"),
          Padding(padding: EdgeInsets.all(20.0), child: TextField(
            controller: foodNameController,
            decoration: new InputDecoration(
                hintText: 'Enter Food',
                labelText: "Food",
                border: OutlineInputBorder()
            ),
          )),
          //Text("Experation:"),

          Center(child:ElevatedButton(
            onPressed: () {
              if( foodNameController.text!="" ){

                FirebaseFunctions().addToShoppingList(name: foodNameController.text);
                Navigator.pop(context);
                setState(() {
                  foodNameController.text="" ;
                });
              }
            },
            child: new Text('Add to Shopping list'),
          )),
          Center(child:ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text('Cancel'),
          )),
        ])
    );
  }
}