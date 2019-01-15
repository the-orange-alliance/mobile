import 'package:flutter/material.dart';
import 'package:toa_flutter/ui/Colors.dart' as TOAColors;
import 'package:toa_flutter/ui/views/match/MatchPage.dart';
import 'package:toa_flutter/ui/views/team/TeamPage.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/MatchParticipant.dart';
import 'package:toa_flutter/models/Event.dart';

class MatchListItem extends StatelessWidget {

  MatchListItem(this.match, {this.justTable = false, this.event});
  final Match match;
  final Event event;
  final bool justTable;

  @override
  Widget build(BuildContext context) {
    Match match = this.match;
    List<MatchParticipant> participants = match.participants;
    List<Widget> row = [];
    List<Widget> redRow = [];
    List<Widget> blueRow = [];

    if (participants.length == 4) {
      redRow.add(bulidTeam(justTable ? 2 : 0, participants, context));
      redRow.add(bulidTeam(justTable ? 3 : 1, participants, context));

      blueRow.add(bulidTeam(justTable ? 0 : 2, participants, context));
      blueRow.add(bulidTeam(justTable ? 1 : 3, participants, context));

    } else if (participants.length == 6) {
      redRow.add(bulidTeam(justTable ? 3 : 0, participants, context));
      redRow.add(bulidTeam(justTable ? 4 : 1, participants, context));
      redRow.add(bulidTeam(justTable ? 5 : 2, participants, context));

      blueRow.add(bulidTeam(justTable ? 0 : 3, participants, context));
      blueRow.add(bulidTeam(justTable ? 1 : 4, participants, context));
      blueRow.add(bulidTeam(justTable ? 2 : 5, participants, context));
    }

    redRow.add(bulidPoints(match.redScore.toString()));
    blueRow.add(bulidPoints(match.blueScore.toString()));

    if (!justTable) {
      // Match name
      row.add(Expanded(
        flex: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0),
          child: Text(
            match.matchName,
            textScaleFactor: 1.1,
            textAlign: TextAlign.center
          ),
        )
      ));
    }

    // Table
    row.add(Expanded(
      flex: justTable ? 10 : 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: TOAColors.Colors().lighterRed,
              border: match.redScore > match.blueScore ? Border.all(color: TOAColors.Colors().red, width: 2) : null
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: redRow
            )
          ),
          Container(
            decoration: BoxDecoration(
              color: TOAColors.Colors().lighterBlue,
              border: match.blueScore > match.redScore ? Border.all(color: TOAColors.Colors().blue, width: 2) : null
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: blueRow
            )
          )
        ]
      )
    ));

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: !justTable ? () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) {
                return MatchPage(matchKey: match.matchKey, match: match, event: event);
              }
            )
          );
        } : null,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(children: row)
        )
      )
    );
  }

  Widget bulidTeam(int index, List<MatchParticipant> participants, BuildContext context) {
    MatchParticipant team = participants[index];
    return Expanded(
      flex: participants.length == 6 ? 2 : 3,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (c) {
                  return TeamPage(teamKey: team.teamKey);
                }
              )
            );
          },
          highlightColor: team.station > 20 ? TOAColors.Colors().lightBlue : TOAColors.Colors().lightRed,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Text(team.teamKey)]
            )
          )
        )
      )
    );
  }

  Widget bulidPoints(String points) {
    if (points == '-1') {
      points = '?';
    }
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text(points)]
        )
      )
    );
  }
}
