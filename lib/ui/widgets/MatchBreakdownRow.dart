import 'package:flutter/material.dart';
import 'package:toa_flutter/ui/Colors.dart' as TOAColors;
import 'package:toa_flutter/ui/views/team/TeamPage.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/MatchParticipant.dart';

enum Alliance {
  RED, BLUE
}

class MatchBreakdownRow extends StatelessWidget {

  MatchBreakdownRow({this.blue, this.red, this.points, this.name, this.title=false});
  final int blue;
  final int red;
  final int points;
  final String name;
  final bool title;

  @override
  Widget build(BuildContext context) {
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
    if (missions  > 0 && !title) {
      text = '$missions (+${missions * points})';
    }
    if (title) {
      text = '$missions Points';
    }

    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: getColor(alliance),
          border: getBorder()
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text(text, style: TextStyle(fontWeight: title ? FontWeight.w600 : FontWeight.normal))]
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
          color: title ? Colors.black12 : Colors.white,
          border: getBorder()
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text(name, style: TextStyle(fontWeight: title ? FontWeight.w600 : FontWeight.normal))]
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
