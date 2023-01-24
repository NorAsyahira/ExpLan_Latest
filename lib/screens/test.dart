import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: ht / 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wd / 40, vertical: 1),
              child: Text(
                "Subject",
                style:
                    TextStyle(fontSize: ht / 30, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: wd / 40, vertical: ht / 60),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // UnderlineInputBorder(),
                  hintText: 'Type Subject name here',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wd / 40, vertical: 1),
              child: Text(
                "Class Link",
                style:
                    TextStyle(fontSize: ht / 30, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: wd / 40, vertical: ht / 60),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // UnderlineInputBorder(),
                  hintText: 'Paste class link here',
                ),
              ),
            ),
            Center(
                child: Text(
              "Timing",
              style: TextStyle(fontSize: ht / 30, fontWeight: FontWeight.w500),
            )),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // BasicTimeField(),
              SizedBox(
                width: wd / 9,
                child: Center(
                  child: Text(
                    "to",
                    style: TextStyle(
                        fontSize: ht / 40, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              // BasicTimeField()
            ]),
            SizedBox(
              height: ht / 40,
            ),
            Center(
                child: Text(
              "Select days of week",
              style: TextStyle(fontSize: ht / 30, fontWeight: FontWeight.w500),
            )),
            // DayPicker(),
            SizedBox(
              height: ht / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Add'),
                  onPressed: () => formKey.currentState?.save(),
                ),
                const SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  child: Text('Reset'),
                  onPressed: () => formKey.currentState?.reset(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
