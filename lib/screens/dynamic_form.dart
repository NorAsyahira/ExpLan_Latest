import 'package:flutter/material.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({super.key});

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              setState(() {
                _count++;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                _count = 0;
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
            setState(() {
            _count++;
            });
        },
              child: Text('Add')),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _count,
                itemBuilder: (context, index) {
                  return _row(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _row(int index) {
    return Row(
      children: [
        Text('ID: $index'),
        SizedBox(width: 30),
        Expanded(child: TextFormField()),
        SizedBox(width: 30),
        Icon(Icons.abc),
        SizedBox(width: 30),
        Icon(Icons.abc)
      ],
    );
  }
}
