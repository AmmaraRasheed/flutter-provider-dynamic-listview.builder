import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_provider/Model.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class MyClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskManager>(
        create: (context) => TaskManager(),
    );
  }
}

class ProviderClass extends StatefulWidget {
  @override
  _ProviderClassState createState() => _ProviderClassState();
}

String CreateCryptoRandomString([int length = 32]) {
  //get random key
}

final fb = FirebaseDatabase.instance.reference().child("Data");
List<Model> itemList=new List();
class _ProviderClassState extends State<ProviderClass> {
  ButtonState state=ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    //call GetData function here

    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider with dynamic listview"),
      ),
      body:Container(
        child: Column(
          children: <Widget>[
            Container(
                height: height-200,
              child: (//Use Consumer class here)(
                builder: (context,myModel,child){
                  return myModel.list.length==0? Text("zero"):ListView.builder(
                    itemCount:myModel.list.length,
                    itemBuilder: (context,index){
                      return Card(
                        elevation: 3.0,
                        color: Colors.white,
                        margin: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 16.0,),
                                Icon(Icons.vibration,
                                  color: Colors.pink,
                                ),
                                SizedBox(width: 16.0,),
                                Text(
                                    myModel.list[index].link,
                                    style: TextStyle(
                                        fontSize: 15
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0,),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: (//Use Consumer class here)(
                builder: (context,model,child){
                  return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: ProgressButton.icon(
                          iconedButtons: {
                            ButtonState.idle:
                            IconedButton(
                                text: "Send",
                                icon: Icon(Icons.send,color: Colors.white),
                                color: Colors.pink.shade500
                            ),
                            ButtonState.loading:
                            IconedButton(
                                text: "Loading",
                                color: Colors.pink[200]
                            ),
                            ButtonState.fail:
                            IconedButton(
                                text: "Failed",
                                icon: Icon(Icons.cancel,color: Colors.white),
                                color: Colors.red.shade300
                            ),
                            ButtonState.success:
                            IconedButton(
                                text: "Success",
                                icon: Icon(Icons.check_circle,color: Colors.white,),
                                color: Colors.green.shade400)
                          },
                          onPressed: (){
                            setState(() {
                              state=ButtonState.loading;
                            });
                            dynamic key=CreateCryptoRandomString(32);
                            fb.child(key).set({
                              "id": key,
                              "link": "EasyCoding",
                            }).then((value) {
                              setState(() {
                                state=ButtonState.idle;
                              });
                            });

                            //call AddNewTask here
                          },
                          state: state
                      )
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}

class TaskManager extends ChangeNotifier{
  List<Model> list=new List();
  GetData(){
    //get data from database
  }

  AddNewTask(String key,String data){
    Model model=Model(
      key,
      data,
    );
    list.add(model);
    notifyListeners();
  }
}

//Watch Full Video At my Youtube:
// EasyCoding with Ammara


