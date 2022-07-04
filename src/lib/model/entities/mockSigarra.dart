import 'package:flutter/foundation.dart';

import 'Group.dart';

class Sigarra {
  final courseList = <String>[
    'Engenharia de Software',
    'Linguagens e Tecnologias Web',
    'Laboratórios de Computadores',
    'Desenho de Algoritmos',
    'Sistema Operativos'
  ];
  final siglaList = <String>['ES', 'LTW', 'LCOM', 'DA', 'SO'];
  List<Group> grupos = <Group>[];

  Sigarra() {
    grupos.add(Group(['João', 'Diogo'], 3, 'LTW', 1));
    grupos.add(Group(['João', 'Diogo'], 3, 'ES', 1));
    grupos.add(Group(['João', 'Diogo'], 3, 'LC', 1));
    grupos.add(Group(['João', 'Diogo'], 3, 'DA', 1));
    grupos.add(Group(['João', 'Diogo'], 3, 'SO', 1));
  }
}