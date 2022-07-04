import 'package:uni/controller/group_logic/manageGroup.dart';
import 'package:uni/controller/local_storage/app_bus_stop_database.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/Group.dart';
import 'package:uni/model/entities/bus_stop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/mockSigarra.dart';
import 'package:uni/view/Pages/unnamed_page_view.dart';
import 'package:uni/view/Widgets/bus_stop_search.dart';
import 'package:uni/view/Widgets/bus_stop_selection_row.dart';
import 'package:uni/view/Widgets/page_title.dart';

import '../../controller/networking/group_api.dart';

class LeaveGroupPage extends StatefulWidget {
  @override
  final String subject;
  final List<Group> api;
  final String name;
  final String subID;

  LeaveGroupPage({Key key, @required this.subject, @required this.api,
    @required this.subID,
    @required this.name}) : super(key:key);
  @override
  State<StatefulWidget> createState() =>
      LeaveGroupPageState(subject,subID, api, name);
}

class LeaveGroupPageState extends UnnamedPageView {

  String subject;
  String name;
  String subID;
  List<Group> api;
  GroupLogic man = new GroupLogic();

  LeaveGroupPageState(this.subject, this.subID,this.api, this.name) {
    this.subject = subject;
    this.name = name;
    this.api = api;
    this.subID = subID;
  }

  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
        body: Container(
            child: FutureBuilder(
                future: getGroups(subID),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    Group grupo = man.getStudentGroup(snapshot.data, context);
                    return ListView(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const SizedBox(height: 10),
                              Text(
                                grupo.course,
                                style: const TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 22),
                              const Text(
                                  'Group Members',
                                  style: TextStyle(
                                    fontSize: 32,
                                  )
                              ),
                              for (var i = 0; i < grupo.getMembers().length; i++)
                                Text(
                                  grupo.getMembers()[i],
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              const SizedBox(height: 50),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(220, 60),
                                    textStyle: const TextStyle(fontSize: 16),
                                    primary: Color.fromARGB(255, 115, 20, 26),
                                  ),
                                  icon: const Icon(Icons.group),
                                  label: const Text("Leave Group"),
                                  onPressed: () => {
                                    man.removeStudent(snapshot.data
                                        ,context, subID),
                                    Navigator.pop(context),
                                  }
                              ),
                              const SizedBox(height: 25),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(220, 60),
                                      textStyle: const TextStyle(fontSize: 16),
                                      primary: Color.fromARGB(255, 115, 20, 26)
                                  ),
                                  icon: const Icon(Icons.group),
                                  label: const Text("Go back"),
                                  onPressed: () => {
                                    Navigator.pop(context)
                                  }
                              )

                            ],
                          )]);
                  }
                  else if(snapshot.hasError) {
                    return Container(
                        child: Center(
                          child: Text("Student Not in Any Group"),
                        )
                    );
                  }
                  else {
                    return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        )
                    );
                  }
                }
            )
        )
    );
  }

  Widget profileInfo(BuildContext context) {
    return Column(children: <Widget>[
      ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          PageTitle(
              name: 'Gestão da Cadeira de ${this.subject}'),
        ],
      ),
    ]);
  }
}
