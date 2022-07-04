
import 'package:uni/controller/networking/group_api.dart';
import 'package:uni/model/entities/Group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/general_page_view.dart';

import '../../controller/group_logic/manageGroup.dart';


class CreateGroupPage extends StatefulWidget {
  @override
  final String subject;
  final List<Group> api;
  final String name;
  final String subID;
  final textCtrl;
  final control =TextEditingController();
  CreateGroupPage({Key key, @required this.subject, @required this.api, @required this.name, @required this.subID, this.textCtrl}) : super(key:key);
  State<StatefulWidget> createState() => CreateGroupPageState(subject,subID, api, name,textCtrl);

}

class CreateGroupPageState extends GeneralPageViewState {

  String subject;
  final String name;
  final List<Group> api;
  final String subID;
  List<Group> courseGroup;
  String capacity = '';
  GroupLogic man = new GroupLogic();
  final textCtrl;
  final textFieldFocusNode = FocusNode();
  CreateGroupPageState(this.subject,this.subID, this.api, this.name, this.textCtrl) {
    this.subject = subject;
    textFieldFocusNode.unfocus();
    textFieldFocusNode.canRequestFocus = false;


  }

  @override
  Widget getBody(BuildContext context) {
    return Container(
            child: FutureBuilder(
                future: getGroups(subID),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            focusNode: textFieldFocusNode,
                            cursorColor: Color.fromARGB(255, 115, 20, 26),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                ),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromARGB(255, 115, 20, 26), width: 2.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                hintText: 'Group Capacity',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  color: Color.fromARGB(255, 115, 20, 26),
                                  onPressed: ()=>{}

                                )
                            ),
                          ),
                          MaterialButton(
                            color: Color.fromARGB(255, 115, 20, 26),
                            child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                )
                            ),
                            onPressed: () {
                              capacity = textCtrl.text;
                              man.createGroup(snapshot.data,
                                  context,5,subID,subject);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
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
        );
  }

}