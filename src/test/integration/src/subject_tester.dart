import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/middleware.dart';
import 'package:uni/controller/networking/network_router.dart';
import 'package:uni/controller/parsers/parser_subject_html.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/course.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:uni/model/entities/profile.dart';
import 'package:uni/model/entities/session.dart';
import 'package:uni/model/entities/subject_info.dart';
import 'package:uni/model/schedule_page_model.dart';
import 'package:uni/redux/action_creators.dart';
import 'package:uni/redux/reducers.dart';

import '../../testable_redux_widget.dart';
import '../../unit/view/Widgets/schedule_slot_test.dart';

class MockClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class UriMatcher extends CustomMatcher {
  UriMatcher(matcher) : super('Uri that has', 'string', matcher);

  @override
  Object featureValueOf(actual) => (actual as Uri).toString();
}

void main() {
  group('Subject Integration Tests', ()
  {
    final mockClient = MockClient();
    final mockResponse = MockResponse();
    final badMockResponse = MockResponse();
    final File file = File('test/integration/resources/ucurr_geral.ficha_uc_view.html');

    test('get Subjects',() async {

      NetworkRouter.httpClient = mockClient;
      when(mockClient.get(Uri.parse('https://sigarra.up.pt/feup/en/UCURR_GERAL.FICHA_UC_VIEW?pv_ocorrencia_id=484425'))).thenAnswer((_) async =>
          http.Response(file.readAsStringSync(), 200));

      expect(await getSubjectFromHtml(await mockClient.get(Uri.parse('https://sigarra.up.pt/feup/en/UCURR_GERAL.FICHA_UC_VIEW?pv_ocorrencia_id=484425'))), isA<List<SubjectInfo>>());

    });
  });
}
