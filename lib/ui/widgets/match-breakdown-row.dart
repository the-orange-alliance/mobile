import 'package:flutter/material.dart';

import '../../internationalization/localizations.dart';
import '../colors.dart' as TOAColors;

enum Alliance {
  RED, BLUE
}
int TRUE_VALUE = -1000;
int FALSE_VALUE = -2000;

class MatchBreakdownRow extends StatelessWidget {

  MatchBreakdownRow({dynamic red, dynamic blue, this.points, this.name, this.title=false, this.text=false}) {
    if (red is bool && !text) {
      this.red = red ? TRUE_VALUE : FALSE_VALUE;
    } else if (red is String && text) {
      this.redText = red;
    } else {
      this.red = red;
    }

    if (blue is bool && !text) {
      this.blue = blue ? TRUE_VALUE : FALSE_VALUE;
    } else if (blue is String && text) {
      this.blueText = blue;
    } else {
      this.blue = blue;
    }
  }

  int red;
  String redText;
  int blue;
  String blueText;
  final int points;
  final String name;
  final bool title;
  final bool text;

  TOALocalizations local;
  ThemeData theme;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);
    theme = Theme.of(context);
    List<Widget> row = [];

    row.add(
        this.text ? buildText(redText, Alliance.RED)
            : buildPoints(red, points, Alliance.RED));
    row.add(buildName(name));
    row.add(this.text
        ? buildText(blueText, Alliance.BLUE)
        : buildPoints(blue, points, Alliance.BLUE));

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: row
      ),
    );
  }


  Widget buildPoints(int missions, int points, Alliance alliance) {
    String text = '0';
    bool isTure = missions == TRUE_VALUE;
    bool isFalse = missions == FALSE_VALUE;
    bool isTrueFalse = isTure || isFalse;

    if (isFalse) {
      text = '';
    } else if (isTure) {
      text = ' (${points > 0 ? '+' : ''}$points)';
    } else if (title) {
      text = '$missions ${local.get('breakdowns.points')}';
    } else if (missions != 0) {
      int total = missions != null ? missions * points : 0;
      text = '$missions (${total > 0 ? '+' : ''}$total)';
    }

    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: getColor(alliance),
          border: getBorder()
        ),
        child: Row(
//          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isTrueFalse)
            Icon(
              isTure ? Icons.check : Icons.close
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: title ? FontWeight.w600 : FontWeight.normal)
            )
          ]
        )
      )
    );
  }

  Widget buildText(String text, Alliance alliance) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration:
            BoxDecoration(color: getColor(alliance), border: getBorder()),
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: title ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildName(String name) {
    return Expanded(
      flex: 4,
      child:
      Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(title ? 0.08 : 0),
          border: getBorder()
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: title ? FontWeight.w600 : FontWeight.normal)
              )
            ]
          )
        )
      )
    );
  }

  Border getBorder() {
    return title ? null : Border(bottom: BorderSide(width: 0.4, color: Colors.black12));
  }

  Color getColor(Alliance alliance) {
    if (alliance == Alliance.RED) {
      return this.title ? TOAColors.Colors().lightRed : TOAColors.Colors().lighterRed;
    } else {
      return this.title ? TOAColors.Colors().lightBlue : TOAColors.Colors().lighterBlue;
    }
  }
}
