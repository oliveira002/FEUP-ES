import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubjectParagraph extends StatelessWidget {
  final String title;
  final String text;

  const SubjectParagraph({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
        Container(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                alignment: Alignment.topLeft,
                child:  Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .apply(fontSizeDelta: -40),
                ),
                ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            alignment: Alignment.bottomLeft,
            child:  Text(text,
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    ]);
  }
}
