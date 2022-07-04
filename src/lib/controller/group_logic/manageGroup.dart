import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/networking/group_api.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/Group.dart';

class GroupLogic {

  bool compareGroups(Group g1, Group g2) {
    List<String> g1M = g1.getMembers();
    List<String> g2M = g2.getMembers();
    g1M.sort();
    g2M.sort();
    bool flag = true;
    if(g1.id != g2.id){
      flag = false;
    }
    else if(g1.capacity != g2.capacity) {
      flag = false;
    }
    else if(g1.course != g2.course) {
      flag = false;
    }
    else if(listEquals(g1M, g2M) == false) {
      flag = false;
    }
    return flag;
  }

  void addStudent(List<Group> grupos, Group g, BuildContext context, String uc) {
    if(checkStudentGroup(grupos, context)) {
      return;
    }
    String upNum = StoreProvider.of<AppState>(context)
        .state
        .content['session'].studentNumber;

    for(var i = 0; i < grupos.length; i++) {
      if(compareGroups(grupos[i], g) && grupos[i].members.length < grupos[i].capacity) {
        grupos[i].members.add(upNum);
        setGroups(uc, grupos);
        break;
      }
    }
  }

  bool checkStudentGroup(List<Group> grupos, BuildContext context) {
  String upNum = StoreProvider.of<AppState>(context)
      .state
      .content['session'].studentNumber;
    for(var i = 0; i < grupos.length; i++) {
      for(var j = 0; j < grupos[i].members.length; j++) {
        if(grupos[i].members[j] == upNum) {
          return true;
        }
      }
    }
    return false;
  }

  void removeStudent(List<Group> grupos, BuildContext context, String uc) {
    String upNum =StoreProvider.of<AppState>(context)
        .state
        .content['session'].studentNumber;
    if(!checkStudentGroup(grupos, context)) {
      return;
    }
    for(var i = 0; i < grupos.length; i++) {
      for(var j = 0; j < grupos[i].members.length; j++) {
        if(grupos[i].members[j] == upNum) {
          grupos[i].members.remove(upNum);
        }
      }
    }
    setGroups(uc, grupos);
  }

  void createGroup(List<Group> grupos,BuildContext context,
      int capacity, String uc,String subject) {
    if(checkStudentGroup(grupos, context)) {
      return;
    }
    List<String> temp = [StoreProvider.of<AppState>(context)
        .state
        .content['session'].studentNumber];
    int idx = 0;
    if(grupos.isNotEmpty) {
      idx = int.parse(grupos[grupos.length - 1].id) + 1;
    }
    grupos.add(Group(temp,capacity,subject,idx));
    setGroups(uc, grupos);
  }

  Group getStudentGroup(List<Group> grupos, BuildContext context) {
    String upNum = StoreProvider.of<AppState>(context)
        .state
        .content['session'].studentNumber;
    for(var i = 0; i < grupos.length; i++) {
      for(var j = 0; j < grupos[i].members.length; j++) {
        if(grupos[i].members[j] == upNum) {
          return grupos[i];
        }
      }
    }
    return Group(["<Invalid Group>"],404,"Not in a group",404);
  }
}
