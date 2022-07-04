import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

abstract class SubjectInfo {
  String title = '';
  String text = '';

  SubjectInfo(String title, String text) {
    this.text = text;
    this.title = title;
  }

  bool isTable();

  Map<String, dynamic> toMap() {
    return {
      'subject': text,
      'groupID': title,
    };
  }
  Widget buildInfo(BuildContext context);

  /// Prints the data in this table to the [Logger] with an INFO level.
  void printExam() {
    Logger().i(
        '''$title - $text''');
  }

  @override
  String toString() {
    return '''$title - $text''';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubjectInfo &&
              runtimeType == other.runtimeType &&
              text == other.text &&
              title == other.title;

  @override
  int get hashCode =>
      title.hashCode ^
      text.hashCode
  ;
}