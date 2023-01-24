import 'package:flutter/material.dart';
import 'package:time2study/screens/signup/home_page.dart';

import '../theme/colors/light_colors.dart';

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  //const TodoPage({super.key});
  final List<String> _todoList = <String>[];

  final TextEditingController _textFieldController = TextEditingController();

  // Generate a single item widget
  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              // ElevatedButton(
              //   child: const Text('ADD'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //     _addTodoItem(_textFieldController.text);
              //   },
              // ),
              // ElevatedButton(
              //   child: const Text('CANCEL'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // )
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addTodoItem(_textFieldController.text);
                  },
                  icon: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 30,
                  )),

              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:
                      Icon(Icons.cancel_rounded, color: Colors.red, size: 30)),
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
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.black,
          )
        ],
      ),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  // Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return Card(
      child: Row(
        children: [
          ListTile(title: Text(title)),
        ],
      ),
    );
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}
