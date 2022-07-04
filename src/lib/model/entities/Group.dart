import 'package:flutter/foundation.dart';

class Group {
  String course;
  String id;
  List<String> members;
  int capacity;
  Group(List<String> numbers, int number, String cadeira,int id1) {
    members = numbers;
    capacity = number;
    course = cadeira;
    id = id1.toString();
  }

  List<String> getMembers() {
    return members;
  }
  Map<String, dynamic> toJson(){
    return {
      'course': course,
      'id': id,
      'members': members,
      'capacity': capacity,
    };
  }

  void removeStudent(String upNumber, String course, List<Group> grupos) {
    for(var i = 0; i < grupos.length; i++) {
      for(var j = 0; j < grupos[i].getMembers().length; j++) {
        if(grupos[i].course == course && grupos[i].getMembers()[j] == upNumber) {
          grupos[i].members.remove(upNumber);
          return;
        }
      }
    }
  }

  void addStudent(String upNumber, Group g, List<Group> grupos) {
    for(var i = 0; i < grupos.length; i++) {
      if(compareGroups(grupos[i], g) && grupos[i].capacity > grupos[i].members.length) {
        grupos[i].members.add(upNumber);
      }
    }
  }

  bool compareGroups(Group g1, Group g2) {
    List<String> g1M = g1.getMembers();
    List<String> g2M = g2.getMembers();
    g1M.sort();
    g2M.sort();
    bool flag = true;

    if(g1.capacity != g2.capacity) {
      flag = false;
    }
    if(g1.capacity != g2.capacity) {
      flag = false;
    }
    if(listEquals(g1M, g2M) == false) {
      flag = false;
    }
    return flag;
  }
}