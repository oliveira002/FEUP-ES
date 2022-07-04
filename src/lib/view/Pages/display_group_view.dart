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

class DisplayGroupPage extends StatefulWidget {
  @override
  final String subject;
  final List<Group> api;
  final String name;
  final Group grupo;
  final String subID;

  DisplayGroupPage({Key key, @required this.subject, @required this.api,
    @required this.subID, @required this.grupo,
    @required this.name}) : super(key:key);
  @override
  State<StatefulWidget> createState() =>
      DisplayGroupPageState(subject,subID, api, grupo, name);
}

class DisplayGroupPageState extends UnnamedPageView {

  String subject;
  String name;
  String subID;
  List<Group> api;
  Group grupo;
  List<Group> temp;
  GroupLogic man = new GroupLogic();

  DisplayGroupPageState(this.subject, this.subID,this.api, this.grupo, this.name) {
    this.subject = subject;
    this.name = name;
    this.api = api;
    this.grupo = grupo;
    this.subID = subID;

  }

  @override
  Widget getBody(BuildContext context) {
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
                 label: const Text("Join Group"),
                onPressed: () => {
                    man.addStudent(api, grupo,context,subID),
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
