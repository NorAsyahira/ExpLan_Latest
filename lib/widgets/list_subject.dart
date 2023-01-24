import 'package:flutter/material.dart';
import 'package:time2study/model/subject1Model.dart';
import 'package:http/http.dart' as http;
import 'package:time2study/screens/add_subject_page%20.dart';
import 'package:time2study/screens/signup/home_page.dart';

class ListSubject extends StatefulWidget {
  const ListSubject({super.key});

  @override
  State<ListSubject> createState() => _ListSubjectState();
}

class _ListSubjectState extends State<ListSubject> {
  Future<List<Subject>?> getSubjects() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/read'));
    if (response.statusCode == 200) {
      var responseString = response.body;
      return subjectFromJson(responseString);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Subject>?>(
          future: getSubjects(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final listSubject = snapshot.data;

              return Container(
                child: ListView.builder(
                    itemCount: listSubject!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        id: listStudent[index].id.toString(),
                                      )),
                            );*/
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(listSubject[index].subjectName),
                              
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}