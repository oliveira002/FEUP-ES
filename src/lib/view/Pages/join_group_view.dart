import 'package:uni/controller/local_storage/app_bus_stop_database.dart';
import 'package:uni/controller/networking/group_api.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/Group.dart';
import 'package:uni/model/entities/bus_stop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/mockSigarra.dart';
import 'package:uni/view/Pages/display_group_view.dart';
import 'package:uni/view/Pages/unnamed_page_view.dart';
import 'package:uni/view/Widgets/bus_stop_search.dart';
import 'package:uni/view/Widgets/bus_stop_selection_row.dart';
import 'package:uni/view/Widgets/page_title.dart';

class JoinGroupPage extends StatefulWidget {
  @override
  final String subject;
  final List<Group> api;
  final String name;
  final String subID;

  JoinGroupPage({Key key, @required this.subject, @required this.api, @required this.name, @required this.subID}) : super(key:key);
  State<StatefulWidget> createState() => JoinGroupPageState(subject, api, name, subID);
}

class JoinGroupPageState extends UnnamedPageView {

  String subject;
  String name;
  final List<Group> api;
  List<Group> courseGroup;
  //Future<List<Group>> oi;
  String subID;
  JoinGroupPageState(this.subject, this.api, this.name, this.subID) {
    this.subject = subject;
    this.subID = subID;
    this.name = name;
  }

  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getGroups(subID),

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          snapshot.data[index].course + ' ' + index
                          .toString() + ' ' + snapshot.data[index].members
                          .length.toString() + '/' +
                          snapshot.data[index].capacity.toString())
                      ,
                      onTap: () =>
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                DisplayGroupPage(grupo: snapshot.data[index],
                                    subject: subject,
                                    api: snapshot.data,
                                    name: name, subID: subID,))),
                      },
                    );
                  }
              );
            }
            else if(snapshot.hasError) {
              return Container(
                  child: Center(
                    child: Text("No Data Found"),
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
