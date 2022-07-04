import 'dart:convert';
import 'package:uni/model/entities/Group.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:http/http.dart' as http;


Future<http.Response> setLectures(List<Lecture> lec , String student) {
  final headers = {'Content-Type': 'application/json','Accept': 'application/json'};
  return http.post(
    Uri.parse('https://web.fe.up.pt/~up202004950/es/action.php?id=4&student='+student),
    headers: headers,
    body: jsonEncode(lec),

  );
}
Future<http.Response> setGroups(String uc ,List<Group> g) {
  final headers = {'Content-Type': 'application/json','Accept': 'application/json'};
  return http.post(
    Uri.parse('https://web.fe.up.pt/~up202004950/es/action.php?id=1&uc='+uc),
    headers: headers,
    body: jsonEncode(g),

  );
}
Future<List<Lecture>> getStudentLectures(String student) async {
  final response = await http.get(
    Uri.parse('https://web.fe.up.pt/~up202004950/es/action.php?id=2&student='+student)
  );
  if(response.body.isEmpty){
    return [];
  }
  final json = jsonDecode(response.body);
  final List<dynamic> dataList = jsonDecode(json);
  final List<Lecture> lec = [];
  for(var vs in dataList){
    Lecture l =
    Lecture.fromHtml(vs['subject'], vs['subjectID'], vs['typeClass'],
        vs['day'],vs["startTime"],vs['blocks'],
        vs['room'],vs['teacher'] ,vs['classNumber']);
    lec.add(l);
  }
  return lec;
}
Future<List<Group>> getGroups(String uc) async {
  final response = await http.get(
      Uri.parse('https://web.fe.up.pt/~up202004950/es/action.php?id=3&uc='+uc)
  );
  if(response.body.isEmpty){
    return [];
  }
  final json = jsonDecode(response.body);
  final List<dynamic> dataList = jsonDecode(json);
  final List<Group> g = [];
  for(var vs in dataList){
    final List<String> pp = [];
    for(var l in vs['members']){
      pp.add(l);
    }
    Group l =
    Group(pp, vs['capacity'], vs['course'],
        int.parse(vs['id']));
    g.add(l);
  }
  return g;
}
