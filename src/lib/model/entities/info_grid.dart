import 'package:flutter/src/widgets/framework.dart';
import 'package:uni/model/entities/subject_info.dart';
import 'package:uni/view/Widgets/print_subject_grid.dart';

class SubjectGridModel extends SubjectInfo{
  List<List<String>> forTable = [];

  SubjectGridModel(String title, String text) : super(title, text);

  @override
  bool isTable() {
    return true;
  }
  void addToTabel(String text1, String text2){
    List<String> s = [];
    s.add(text1);
    s.add(text2);
    forTable.add(s);
  }
  List<List<String>> getTable(){
    return forTable;
  }

  @override
  Widget buildInfo(BuildContext context) {
    return SubjectGrid(forTable : forTable,title: title).build(context);
  }

}