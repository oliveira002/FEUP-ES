import 'dart:async';

import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:uni/model/entities/info_grid.dart';
import 'package:uni/model/entities/info_paragraph.dart';
import 'package:uni/model/entities/subject_info.dart';

Future<List<SubjectInfo>> getSubjectFromHtml(http.Response response) async {
  final document = parse(response.body);

  final List<SubjectInfo> SubjectInfoList = [];
  final objects = document.querySelectorAll('#conteudoinner h3');

  SubjectParagraphModel goals,frequency,program;
  SubjectGridModel evaluationComponents,teachers;

  for(int i = 0; i < objects.length; i++){
    final object = objects[i]; 
    switch (object.text) { 
      case 'Docência - Horas': teachers = teachersParser(object);
      break; 
      case 'Objetivos': goals = generalParser(object, response.body,'Objetivos');
      break; 
      case 'Programa': program = generalParser(object, response.body,'Programa');
      break; 
      case 'Componentes de Avaliação': evaluationComponents =
          getEvalComponets(object);
      break;
      case 'Obtenção de frequência': frequency =
          generalParser(object, response.body,'Obtenção de frequência');
      break;
      default: 
      break; 
      }
  }
  SubjectInfoList.add(teachers);
  SubjectInfoList.add(goals);
  SubjectInfoList.add(program);
  SubjectInfoList.add(evaluationComponents);
  SubjectInfoList.add(frequency);
  return SubjectInfoList;
}
SubjectGridModel teachersParser(Element titleElement){
  final SubjectGridModel Teachers = SubjectGridModel('Docência - Horas','');
  final table1 = titleElement.nextElementSibling;
  final table = table1.nextElementSibling;
  for (var row in table.querySelectorAll('tr.d'))
  {
    Teachers.addToTabel(
        row.children[0].text, row.children[2].text);
  }
  return Teachers;
}
SubjectParagraphModel generalParser(Element titleElement,
    String body,String title) {
 final String htmlDescription = getNextElement(body, titleElement.outerHtml);
 final doc = parse(htmlDescription);
 SubjectParagraphModel r = SubjectParagraphModel(
     title,parse(doc.body.text).documentElement.text);
 return r;
}
String getNextElement(String body, String elementOuterHtml) {
 final int index = body.indexOf(elementOuterHtml) + elementOuterHtml.length;
  return body.substring(index, body.indexOf('<h3>', index));
}
SubjectGridModel getEvalComponets(Element titleElement){
  final SubjectGridModel eval = SubjectGridModel('Componentes de Avaliação','');
  final table = titleElement.nextElementSibling;
  for (var row in table.querySelectorAll('tr.d'))
  {
    eval.addToTabel(
        row.children[0].text, row.children[1].text);
  }
  return eval;
}

