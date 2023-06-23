import 'package:flutter/material.dart';

import '../../internationalization/localizations.dart';
import '../colors.dart' as TOAColors;

int TRUE_VALUE = -1000;
int FALSE_VALUE = -2000;

class RemoteMatchBreakdownRow extends StatelessWidget {

  RemoteMatchBreakdownRow({dynamic team, this.points, this.name, this.title=false, this.text=false}) {
    if (team is bool && !text) {
      this.team = team ? TRUE_VALUE : FALSE_VALUE;
    } else if (team is String && text) {
      this.teamText = team;
    } else {
      this.team = team;
    }
  }

  int team;
  String teamText;
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

    row.add(buildName(name));
    row.add(this.text ? buildText(teamText)
        : buildPoints(team, points));

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: row
      ),
    );
  }


  Widget buildPoints(int missions, int points) {
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
          color: getColor(),
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

  Widget buildText(String text) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: getColor(),
          border: getBorder()
        ),
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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

  Color getColor() {
    if (theme.brightness == Brightness.light) {
      return this.title
          ? TOAColors.Colors.toaColors.shade300
          : TOAColors.Colors.toaColors.shade200;
    } else {
      return Colors.black.withOpacity(this.title ? 0.16 : 0.08);
    }
  }
}
