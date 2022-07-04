import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:uni/controller/networking/network_router.dart';

import 'package:uni/controller/parsers/parser_subject_html.dart';

import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/subject_info.dart';

class SubjectFetcherHtml {

  Future<List<SubjectInfo>> getSubectPage(BuildContext context , String subjectID) async {

    final List<SubjectInfo> subjects = await getSubjectFromHtml(
        await NetworkRouter.getWithCookies(NetworkRouter.getBaseUrlFromSession(
            StoreProvider.of<AppState>(context).state.content['session']) +
            '''UCURR_GERAL.FICHA_UC_VIEW?pv_ocorrencia_id=${subjectID}''',{},
            StoreProvider.of<AppState>(context).state.content['session']));
    return subjects;
  }
}
