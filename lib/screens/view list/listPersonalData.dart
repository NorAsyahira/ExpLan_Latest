import 'package:flutter/material.dart';
import 'package:time2study/model/personalDataModel.dart';
import 'package:http/http.dart' as http;
import 'package:time2study/model/userModel.dart';

import '../../theme/colors/light_colors.dart';

class ListPersonalData extends StatefulWidget {
  const ListPersonalData({super.key});

  @override
  State<ListPersonalData> createState() => _ListPersonalDataState();
}

class _ListPersonalDataState extends State<ListPersonalData> {
  Future<List<UsersModel>?> getPersonalDatas() async {
    //list <> tu adalah model
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/readPersonalData'));
    if (response.statusCode == 200) {
      var responseString = response.body;
      return usersModelFromJson(responseString);
    }
    //nama model jgk
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("#"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudent()),
          );*/
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: getPersonalDatas(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            final listPersonalData = snapshot.data;
            return Container(
              child: ListView.builder(
                  itemCount: listPersonalData!.length,
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
                          shadowColor: Colors.black,
                          color: LightColors.kLavender,
                          child: ListTile(
                            //leading: Icon(Icons.icecream),
                            /*leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
                              ),*/
                            title: Text(listPersonalData[index].username),
                            subtitle: Text(
                                listPersonalData[index].birthday.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    color: Colors.green,
                                    icon: Icon(Icons.edit)),
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
    );
  }
}
