import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubjectGrid extends StatelessWidget {
  final List<List<String>> forTable;
  final String title;
  const SubjectGrid({Key key, this.title, this.forTable}) : super(key: key);

  List<TableRow> getGrid(BuildContext context){
    final List<TableRow> list = [];
    for(var value in forTable){
      if(value[0] == 'Teóricas'){
        list.add(TableRow(
            children: [
              TableCell(child: 
              Container( 
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                  child:(
              
              Text(value[0],
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .apply(fontSizeDelta: 3)
              )))),
              TableCell(
                child: Text(''),
              ),
            ])
        );
      }
      else if(value[0] == 'Práticas Laboratoriais'){
        list.add(TableRow(
            children: [
              TableCell(
                  child:(Container(
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                  child: Text(value[0],
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .apply(fontSizeDelta: 3),
        ))
              )),
              TableCell(
                child: Text(''),
              ),
            ])
        );
      } else if(value[0] == 'Teórico-Práticas'){
        list.add(TableRow(
            children: [
              TableCell(
                  child:(Container(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: Text(value[0],
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .apply(fontSizeDelta: 3),
                      ))
                  )),
              TableCell(
                child: Text(''),
              ),
            ])
        );
      }
      else {
        list.add(TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                child:
              Text(value[0],
                  style: TextStyle(fontSize: 16,)
              ),))
              ,
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  alignment: Alignment.centerLeft,
                  child:
                  Text(value[1], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)
                  ),
                )
              ),
            ])
        );
      }



    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        alignment: Alignment.topLeft,
        child:  Text(title,
        style: Theme.of(context)
            .textTheme
            .headline1
            .apply(fontSizeDelta: -40),
        )),
      Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Table(
        children: getGrid(context),
          border: TableBorder.all(width: 1, 
              color:  Color(0x648c2d19),
              borderRadius: BorderRadius.circular(5.0)
          ),
      ),
      ),
    ]);
  }
}