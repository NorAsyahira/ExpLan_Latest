import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:time2study/screens/formData/activity_time.dart';
import 'package:time2study/widgets/back_button.dart';
import '../../model/activityModel.dart';
import '../../theme/colors/light_colors.dart';

class ListActivityTime extends StatefulWidget {
  //String userId;

  //ListActivityTime({required this.userId});
  //int activity_id;
  const ListActivityTime({super.key});
  /*ListActivityTime({
    required this.activity_id,
  });*/

  @override
  State<ListActivityTime> createState() => _ListActivityTimeState();
}

class _ListActivityTimeState extends State<ListActivityTime> {
  bool value = false;

  Future<List<ActivityModel>?> getActivityTimes() async {
    //list <> tu adalah model
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/readActivityTime"));
    //.get(Uri.parse("http://10.0.2.2:8000/api/${widget.userId}/readActivityTime"));
    if (response.statusCode == 200) {
      var responseString = response.body;
      return activityModelFromJson(responseString);
    }
    //nama model jgk
  }

  Future<ActivityModel?> deleteActivity(context) async {
    final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/{activity_id}/deletePersonalData"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kLightYellow,
        elevation: 0.5,
        // centerTitle: true,
        title: Text(
          'List Activity Time',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        /*title: Text("List Activity Time", style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,

          ),),*/
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityTime()), //next page study time
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            0,
            0,
            0,
            0,
          ),
          child: FutureBuilder(
            future: getActivityTimes(),
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
                              color: Color.fromARGB(253, 255, 255, 255),
                              child: ListTile(
                                //leading: Icon(Icons.icecream),
                                /*leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                          "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
                                    ),*/
                                title:
                                    Text(listActivityTime[index].activityName),
                                subtitle:
                                    Text(listActivityTime[index].activityType),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     color: Colors.green,
                                    //     icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          activity_id:
                                          listActivityTime[index]
                                              .activityId
                                              .toString();
                                          deleteActivity(context);
                                        },
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add'),
        backgroundColor: LightColors.kGreen,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const ActivityTime()), //next page study time
          );
        },
      ),
    );
  }
}
