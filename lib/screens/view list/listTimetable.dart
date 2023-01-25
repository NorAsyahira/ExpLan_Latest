import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:time2study/model/timetableModel.dart';
import 'package:http/http.dart' as http;
import 'package:time2study/screens/formData/timetable.dart';

import '../../theme/colors/light_colors.dart';

class ListTimetable extends StatefulWidget {
  const ListTimetable({super.key});

  @override
  State<ListTimetable> createState() => _ListTimetableState();
}

class _ListTimetableState extends State<ListTimetable> {
  Future<List<TimetableModel>?> getTimetables() async {
    //list <> tu adalah model

    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/readData"));
    //.get(Uri.parse("http://10.0.2.2:8000/api/${widget.userId}/readActivityTime"));
    if (response.statusCode == 200) {
      var responseString = response.body;
      return timetableModelFromJson(responseString);
    }
    //nama model jgk
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kLightYellow,
        elevation: 0.5,
        // centerTitle: true,
        title: Text(
          'List Timetable',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TimetableStudent()), //next page study time
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          0,
          0,
          0,
          0,
        ),
        child: FutureBuilder(
          future: getTimetables(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              final listActivityTime = snapshot.data;
              return Container(
                child: ListView.builder(
                    itemCount: listActivityTime!.length,
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
                          child: Card(
                            elevation: 10,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(15),
                            // ),
                            shadowColor: Color.fromARGB(117, 255, 255, 255),
                            //color: LightColors.kLightYellow,
                            color: Color.fromARGB(204, 255, 255, 255),
                            child: ListTile(
                              //leading: Icon(Icons.icecream),
                              /*leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                          "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
                                    ),*/
                              title: Row(
                                children: [
                                  Text(listActivityTime[index].subjectCode),
                                  SizedBox(width: 5),
                                  Text("(" +
                                      listActivityTime[index].group +
                                      ")"),
                                  Row()
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(listActivityTime[index].day),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(listActivityTime[index].startTime),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(listActivityTime[index].endTime),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(
                                  //     onPressed: () {},
                                  //     icon:
                                  //         Icon(Icons.arrow_forward_ios_rounded))
                                  // IconButton(
                                  //     onPressed: () {},
                                  //     color: Colors.green,
                                  //     icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {},
                                      color: Colors.redAccent,
                                      icon: Icon(Icons.delete_rounded))
                                ],
                              ),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add'),
        // backgroundColor: LightColors.kRed,
        backgroundColor: LightColors.kGreen,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TimetableStudent()), //next page study time
          );
        },
      ),
    );
  }
}
