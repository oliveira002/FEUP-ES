import 'package:tuple/tuple.dart';
import 'package:uni/controller/networking/group_api.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/Group.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/view/Pages/overview_group_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

class OverviewPage extends StatefulWidget {
  final String subID;
  const OverviewPage({Key key, this.subID}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState(subID);
}

class _OverviewPageState extends SecondaryPageViewState
    with SingleTickerProviderStateMixin {
  final int weekDay = DateTime.now().weekday;
  final String subID;
  TabController tabController;
  ScrollController scrollViewController;

  final List<String> daysOfTheWeek = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];

  _OverviewPageState(this.subID);

  // ignore: non_constant_identifier_names
  Future<List<List<Lecture>>> _groupLecturesByDay(String subID,BuildContext context) async{
    final String UP = StoreProvider.of<AppState>(context)
        .state
        .content['session'].studentNumber;
    final aggLectures = <List<Lecture>>[];
    final List<Lecture> schedule = [];
    final List<Group> gs = await getGroups(subID);
    final List<String> upS = [];
    for(int x = 0; x < gs.length; x++){
      if(gs[x].members.contains(UP)){
        upS.addAll(gs[x].members);
        break;
      }
    }
    for(int x = 0; x < upS.length; x++){
      schedule.addAll(await getStudentLectures(upS[x]));
    }
    for (int i = 0; i < daysOfTheWeek.length; i++) {
      final List<Lecture> lectures = <Lecture>[];
      for (int j = 0; j < schedule.length; j++) {
        if (schedule[j].day == i) lectures.add(schedule[j]);
      }
      aggLectures.add(lectures);
    }
    for(int day = 0; day < aggLectures.length;day++){
      for(int lec = 0;lec < aggLectures[day].length;lec++){
        for(int lec1 = lec+1;lec1 < aggLectures[day].length;lec1++){
          if(aggLectures[day][lec].startTime ==
              aggLectures[day][lec1].startTime){
            if(aggLectures[day][lec1].blocks <= aggLectures[day][lec].blocks){
              aggLectures[day].removeAt(lec1);
              lec1--;
            }
          }
        }
      }
    }
    return aggLectures;
  }


  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: daysOfTheWeek.length);
    final offset = (weekDay > 5) ? 0 : (weekDay - 1) % daysOfTheWeek.length;
    tabController.animateTo((tabController.index + offset));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
      final scheduleStatus = RequestStatus.successful;
      return Scaffold(
          body: Container(
              child: FutureBuilder(
                  future: _groupLecturesByDay(subID,context),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      return OverviewPageView(
                          tabController: tabController,
                          scrollViewController: scrollViewController,
                          daysOfTheWeek: daysOfTheWeek,
                          aggLectures: snapshot.data,
                          scheduleStatus: scheduleStatus);
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
          )
      );
  }
}
