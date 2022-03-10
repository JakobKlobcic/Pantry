import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/Recepie.dart';

class FirebaseFunctions{
  CollectionReference pantry = FirebaseFirestore.instance.collection('Pantry');
  CollectionReference shoppingList = FirebaseFirestore.instance.collection('ShoppingList');
  CollectionReference recepies = FirebaseFirestore.instance.collection('Recipies');



  Future<void> addToPantry({name, date}) {
    // Call the user's CollectionReference to add a new user
    return pantry
        .add({
      'name': name, // John Doe
      'experation': date, // Stokes and Sons
    })
        .then((value) => print("Food Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> deleteFromPantry(var id) {
    return pantry
        .doc(id)
        .delete()
        .then((value) => print("Deleted from pantry"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> addToShoppingList({name}) {
    return shoppingList
      .add({
      'name': name,
      'bought': false,
      })
      .then((value) => print("Food Added to shopping list"))
      .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> deleteFromShoppingList(var id) {
    return shoppingList
        .doc(id)
        .delete()
        .then((value) => print("Delete from shopping list"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> checkBought(var id, bool? bought) {
    return shoppingList
        .doc(id)
        .update({'bought': bought})
        .then((value) => print("The item has been bought"))
        .catchError((error) => print("Failed to buy the item:  $error"));
  }

  Future<List<Recepie>> getOrderedRecepies() async {
  List<Recepie> returnList = [];
  //TODO: get only results where timestamp is before (today + 7 days) and after today
    QuerySnapshot foodList = await pantry.get();

    QuerySnapshot recepiesList=await recepies.get();

  recepiesList.docs.forEach((recepieDoc){
      int ingredientCount = 0;
      foodList.docs.forEach((foodDoc) {
        if(recepieDoc["ingredients"].contains(foodDoc["name"])){
          ingredientCount++;
        }
      });
      returnList.add(new Recepie(id: recepieDoc.id, name: recepieDoc["name"], ingredients: recepieDoc["ingredients"], count: ingredientCount ));
    });
    return returnList;
  }
  Future<Recepie> getRecipie(var id) async{
    FirebaseFirestore.instance
        .collection('Recipies')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          var data = documentSnapshot.data;
          print("--"+data.toString());
      if (documentSnapshot.exists) {
        print("it exists");
        return new Recepie(name: documentSnapshot["name"], id: documentSnapshot["id"], ingredients:documentSnapshot["ingredients"], description: documentSnapshot["description"] );
      } else {
        print('Document does not exist on the database');
      }
    });
    return new Recepie();
  }
}