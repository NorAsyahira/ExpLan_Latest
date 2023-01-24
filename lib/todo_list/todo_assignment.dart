import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:time2study/model/todo_assignment_model.dart';
import '../screens/signup/home_page.dart';
import '../theme/colors/light_colors.dart';

class TodoAssignment extends StatefulWidget {
  const TodoAssignment({super.key});

  @override
  State<TodoAssignment> createState() => _TodoAssignmentState();
}

class _TodoAssignmentState extends State<TodoAssignment> {
  bool isChecked = false;

  TextEditingController todoNameController = TextEditingController();

  Future todo(context) async {
    var data = {
      'todo_name': todoNameController.text,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/storeTodo'),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
      },
    );
  }

  Future<List<TodoAssignmentModel>?> getTodoAssignment() async {
    //list <> tu adalah model

    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/readTodo"));
    //.get(Uri.parse("http://10.0.2.2:8000/api/${widget.userId}/readActivityTime"));
    if (response.statusCode == 200) {
      var responseString = response.body;
      return todoAssignmentModelFromJson(responseString);
    }
    //nama model jgk
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text('Todo Name '),
            content: TextField(
              controller: todoNameController,
              decoration: InputDecoration(hintText: "Typing here..."),
            ),
            actions: [
              new TextButton(
                child: new Text('Save'),
                onPressed: () {
                  todo(context);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.kLightYellow,
          //centerTitle: true,
          elevation: 1,
          title: Text(
            'Study Plan',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()), //next page study time
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => _displayDialog(context),
              icon: Icon(Icons.add),
              color: Colors.black,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
            10,
            20,
            10,
            0,
          ),
          child: FutureBuilder(
            future: getTodoAssignment(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                final listTodoAssignment = snapshot.data;
                return Container(
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        //<-- SEE HERE
                        return Divider(
                          thickness: 2,
                        );
                      },
                      itemCount: listTodoAssignment!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecondPage(
                                              id: listStudent[index].id.toString(),
                                            )),
                                  );*/
                            },
                            child: ListTile(
                              //leading: Icon(Icons.icecream),
                              /*leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                          "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
                                    ),*/
                              title: Row(
                                children: [
                                  Text(listTodoAssignment[index].todoName),
                                ],
                              ),

                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: this.isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
