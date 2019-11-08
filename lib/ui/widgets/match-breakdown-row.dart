import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../internationalization/localizations.dart';
import '../colors.dart' as TOAColors;

enum Alliance {
  RED, BLUE
}
int TRUE_VALUE = -1000;
int FALSE_VALUE = -2000;

class MatchBreakdownRow extends StatelessWidget {

  MatchBreakdownRow({dynamic red, dynamic blue, this.points, this.name, this.title=false}) {
    if (red is bool) {
      this.red = red ? TRUE_VALUE : FALSE_VALUE;
    } else {
      this.red = red;
    }

    if (blue is bool) {
      this.blue = blue ? TRUE_VALUE : FALSE_VALUE;
    } else {
      this.blue = blue;
    }
  }

  int red;
  int blue;
  final int points;
  final String name;
  final bool title;

  TOALocalizations local;
  ThemeData theme;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);
    theme = Theme.of(context);
    List<Widget> row = [];

    row.add(bulidPoints(red, points, Alliance.RED));
    row.add(bulidName(name));
    row.add(bulidPoints(blue, points, Alliance.BLUE));


    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: row
      ),
    );
  }


  Widget bulidPoints(int missions, int points, Alliance alliance) {
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
      int total = missions * points;
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

  Widget bulidName(String name) {
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
