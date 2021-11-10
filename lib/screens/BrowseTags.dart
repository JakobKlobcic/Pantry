import 'package:byu_studies/fetch_data.dart';
import 'package:byu_studies/models/RouteArguments.dart';
import 'package:byu_studies/models/Tag.dart';
import 'package:byu_studies/widgets/TagListItem.dart';
import 'package:flutter/material.dart';

class BrowseTags extends StatefulWidget{
  @override
  _BrowseTags createState() => _BrowseTags();
}

class _BrowseTags extends State<BrowseTags> {
  var enteredSearch ="";
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    var mainNavKey=args.key;
    return Scaffold(
        body: Column(
            children:[
              TextField(
                onChanged: (text){
                  setState(() {
                    enteredSearch = text;
                  });
                },
                controller: _controller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        if(_controller.text!="") {
                          setState(() {
                            _controller.text = "";
                            enteredSearch = "";
                          });
                        }
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none
                ),
              ),
              Expanded(child:
              FutureBuilder(
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.waiting ) {
                    return Center(child: new CircularProgressIndicator());
                  }
                  final data = projectSnap.data as List<Tag>;
                  return Scaffold(
                    body:Padding(
                        padding: EdgeInsets.all(8.0),
                        child:ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            Tag tag = data[index];
                            return new InkResponse(
                              child:TagListItem(tag),
                              onTap: ()=>{
                                args.key.currentState!.pushNamed('/tag_details', arguments:new Arguments(key:mainNavKey, data:tag))
                              },
                            );
                          },
                        )
                    ),
                  );
                },
                future: FetchData().fetchTagList(enteredSearch),
              )
              )
            ]
        ),
    );
  }
}