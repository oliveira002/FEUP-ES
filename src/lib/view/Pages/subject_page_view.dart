import 'package:flutter/material.dart';
import 'package:uni/controller/networking/group_api.dart';
import 'package:uni/model/entities/Group.dart';
import 'package:uni/model/entities/subject_info.dart';
import 'package:uni/redux/action_creators.dart';
import 'package:uni/view/Pages/unnamed_page_view.dart';
import 'package:uni/view/Widgets/print_group_management.dart';
import 'package:uni/view/Widgets/page_title.dart';

class SubjectPageView extends StatefulWidget {
  final String name;
  final String email;
  final String subject;
  final String subjectID;
  final String profileUP;
  final Map<String, String> currentState;
  SubjectPageView(
      {Key key,
      @required this.name,
      @required this.email,
      @required this.currentState,
      @required this.subject,
      @required this.subjectID,
      @required this.profileUP});
  @override
  State<StatefulWidget> createState() => SubjectPageViewState(
      name: name, email: email, currentState: currentState, subject: subject,
      subjectID:subjectID ,profileUP: profileUP);
}

/// Manages the 'Personal user page' section.
class SubjectPageViewState extends UnnamedPageView {
  SubjectPageViewState(
      {Key key,
      @required this.name,
      @required this.email,
      @required this.currentState,
      @required this.subject,
      @required this.subjectID,
      @required this.profileUP,});
  final String name;
  final String email;
  final String subject;
  final String subjectID;
  final String profileUP;
  List<Group> api = [];
  final Map<String, String> currentState;
  List<SubjectInfo> stuff = [];

  @override
  Widget getBody(BuildContext context) {
    if(stuff.isEmpty) {
      getPageCode(context);
    }
    return ListView(shrinkWrap: false, children: childrenList(context));
  }

  @override
  Widget getTopRightButton(BuildContext context) {
    return Container();
  }

  List<Widget> childrenList(BuildContext context) {
    final List<Widget> list = [];
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.add(profileInfo(context));
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.add(PrintInfoGroup(subject: subject, name:name,
        subID: subjectID,api:api));
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.addAll(childrenList1(context));
    return list;
  }


  void function(){
    setState(() {});
  }

  void getPageCode(BuildContext context) async {
    stuff = await getSubectPage(context,subjectID).whenComplete(
            () => function());
  }
  void getGroupApi() async {
    api = await getGroups(subjectID).whenComplete(
            () => function());
  }

  List<Widget> childrenList1(BuildContext context) {
    final List<Widget> list = [];
    for(var info in stuff){
      list.add(Padding(padding: const EdgeInsets.all(5.0)));
      list.add(info.buildInfo(context));
    }
    return list;
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
