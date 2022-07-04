import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/group_logic/manageGroup.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/Group.dart';
import 'package:uni/model/overview_page_model.dart';
import 'package:uni/view/Pages/create_group_view.dart';
import 'package:uni/view/Pages/join_group_view.dart';
import 'package:uni/view/Pages/leave_group_view.dart';
import 'package:uni/view/Widgets/row_container.dart';
import 'generic_card.dart';


class PrintInfoGroup extends GenericCard {
  final List<Group> api;
  final String subject;
  final String name;
  final String subID;
  final textCtrl = TextEditingController();
  GroupLogic man = new GroupLogic();
  PrintInfoGroup( {Key key, @required this.subject,@required this.api,
    @required this.name, @required this.subID}) : super(key: key);
Widget getRowContainer(String text,BuildContext context){
    return RowContainer(
        child: Center(
        child: Text(text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(fontSizeDelta: 3)),
    ));
  }
//_OverviewPageState
  @override
  Widget buildCardContent(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Table(
            columnWidths: {1: FractionColumnWidth(.4)},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) => JoinGroupPage(subject: subject,
                            api : api, name: name, subID: subID)));
                  },
                child: Container(
                    width: 200,
                    height: 140,
                    padding: const EdgeInsets.only(
                        top: 40.0, bottom: 40.0, right: 5.0),
                    child: getRowContainer('Juntar grupo',context),
                )
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) => LeaveGroupPage(subject: subject,
                              api : api, name: name, subID: subID)));
                    },
                child: Container(
                  width: 200,
                  height: 140,
                    padding: const EdgeInsets.only(
                        top: 40.0, bottom: 40.0, right: 5.0),
                    child: getRowContainer('Sair grupo',context),
                )
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) => CreateGroupPage(subject: subject,
                            api : api, name : name,
                            subID: subID,textCtrl: textCtrl)));
                  },
                child: Container(
                    width: 200,
                    height: 140,
                    padding: const EdgeInsets.only(
                        top: 40.0, bottom: 40.0),
                    child: getRowContainer('Criar grupo',context),
                )
                ),
              ])
            ]),
        StoreConnector<AppState, String>(
            converter: (store) => store.state.content['printRefreshTime'],
            builder: (context, printRefreshTime) =>
                showLastRefreshedTime(printRefreshTime, context))
      ],
    );
  }

  @override
  String getTitle() => 'Grupos';

  @override
  onClick(BuildContext context) =>
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              OverviewPage(key:key,subID: subID)));
}

