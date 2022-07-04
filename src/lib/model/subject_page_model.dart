import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/networking/group_api.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/view/Pages/subject_page_view.dart';

class SubjectPage extends StatefulWidget {
  final String subject;
  final String subjectID;

  
  @override
  _SubjectPageState createState() => _SubjectPageState();
  
  SubjectPage({Key key , this.subject, this.subjectID}) :
        super(key: key);
}

class SubjectPageClass extends StatelessWidget {
  final String subject;
  final String subjectID;

  SubjectPageClass(this.subject,this.subjectID){
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SubjectPage(subject: this.subject, subjectID: this.subjectID)
    );
  }
}

class _SubjectPageState extends State<SubjectPage> {
  String name;
  String email;
  Map<String, String> currentState;
  String subject;
  String subjectID;
  String profileUP;


  @override
  void initState() {
    super.initState();
    name = '';
    email = '';
    currentState = {};
    subject = widget.subject;
  }

  @override
  Widget build(BuildContext context) {
    updateInfo();
    return SubjectPageView(
        name: name, email: email, currentState: currentState,subject: subject,
        subjectID:subjectID , profileUP: profileUP,);
  }

  void updateInfo() async {
    setState(() {
      if (StoreProvider.of<AppState>(context).state.content['profile'] !=
          null) {
        name =
            StoreProvider.of<AppState>(context).state.content['profile'].name;
        email =
            StoreProvider.of<AppState>(context).state.content['profile'].email;
        currentState =
            StoreProvider.of<AppState>(context).state.content['coursesStates'];
        profileUP = StoreProvider.of<AppState>(context)
            .state
            .content['session'].studentNumber;
        final List<Lecture> stLecture = StoreProvider.of<AppState>
          (context).state.content['schedule'];
        if(stLecture.isNotEmpty){
          setLectures(stLecture,profileUP);
        }
      }
      subject = widget.subject;
      subjectID = widget.subjectID;
    }
    );
  }
}
