import 'package:flutter/src/widgets/framework.dart';
import 'package:uni/model/entities/subject_info.dart';
import 'package:uni/view/Widgets/print_subject_paragraph.dart';

class SubjectParagraphModel extends SubjectInfo{

  SubjectParagraphModel(String groupID, String subject) :
        super(groupID, subject);

  @override
  bool isTable() {
    return false;
  }

  @override
  Widget buildInfo(BuildContext context) {
    return SubjectParagraph(title : title, text: text).build(context);
  }

}