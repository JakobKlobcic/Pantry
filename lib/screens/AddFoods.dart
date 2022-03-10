import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../firebase/FirebaseFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoods extends StatefulWidget{
  @override
  _AddFoods createState() => _AddFoods();
}

class _AddFoods extends State<AddFoods>{

  final TextEditingController foodNameController = new TextEditingController();
  final TextEditingController experationDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to Pantry"),
        backgroundColor: Color(0xff7ED957),
        leading: Padding(padding: EdgeInsets.only(left:10.0,top: 10.0, bottom: 10.0),
            child:Image.asset("assets/images/logo.png", height: 100,
              width: 100,)),
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
        Padding(padding: EdgeInsets.all(20.0), child:
          TextField(controller: experationDateController, onTap: () async {
            var date =await _selectDate(context);
            final DateFormat formatter = DateFormat('MM/dd/yyyy');
            final String formatted = formatter.format(date);
            experationDateController.text = formatted;
          },
          showCursor: true,
          readOnly: true,
          decoration: new InputDecoration(
              hintText: 'Enter Experation date',
              border: OutlineInputBorder()
          ),
          )
        ),
        Center(child:ElevatedButton(
          onPressed: () {
            if( foodNameController.text!="" && experationDateController.text!=""){
              DateTime date = new DateFormat('MM/dd/yyyy').parse(experationDateController.text);
              Timestamp myTimeStamp = Timestamp.fromDate(date);
              FirebaseFunctions().addToPantry(name: foodNameController.text, date: myTimeStamp);
              Navigator.pop(context);
              setState(() {
                foodNameController.text="" ;
                experationDateController.text="";
              });
            }
          },
          child: new Text('Add to Pantry'),
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
  _selectDate(BuildContext context) async {
    DateTime today = new DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != today)
      setState(() {
        today = picked;
      });
    return picked;
  }
  
}