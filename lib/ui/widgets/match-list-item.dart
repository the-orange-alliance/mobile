import 'package:flutter/material.dart';

import '../../models/event.dart';
import '../../models/match.dart';
import '../../models/match-participant.dart';
import '../colors.dart' as TOAColors;
import '../views/match/match-page.dart';
import '../views/team/team-page.dart';

class MatchListItem extends StatelessWidget {

  MatchListItem(this.match, {this.justTable = false, this.event});
  final Match match;
  final Event event;
  final bool justTable;

  @override
  Widget build(BuildContext context) {
    Match match = this.match;
    List<MatchParticipant> participants = match.participants;
    bool points = match.redScore != null && match.redScore != -1
        && match.blueScore != null && match.blueScore != -1;

    List<Widget> row = [];
    List<Widget> redRow = [];
    List<Widget> blueRow = [];

    if (participants.length == 4) {
      redRow.add(bulidTeam(0, participants, context));
      redRow.add(bulidTeam(1, participants, context));

      blueRow.add(bulidTeam(2, participants, context));
      blueRow.add(bulidTeam(3, participants, context));

    } else if (participants.length == 6) {
      redRow.add(bulidTeam(0, participants, context));
      redRow.add(bulidTeam(1, participants, context));
      redRow.add(bulidTeam(2, participants, context));

      blueRow.add(bulidTeam(3, participants, context));
      blueRow.add(bulidTeam(4, participants, context));
      blueRow.add(bulidTeam(5, participants, context));
    } else if (participants.length == 1) {
      blueRow.add(bulidTeam(0, participants, context));
    }

    if (participants.length == 1) {
      blueRow.add(bulidPoints(match.redScore.toString()));
    } else {
      redRow.add(bulidPoints(match.redScore.toString()));
      blueRow.add(bulidPoints(match.blueScore.toString()));
    }

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
              border: points && match.redScore > match.blueScore ? Border.all(color: TOAColors.Colors().red, width: 2) : null
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: redRow
            )
          ),
          Container(
            decoration: BoxDecoration(
              color: TOAColors.Colors().lighterBlue,
              border: points && match.blueScore > match.redScore ? Border.all(color: TOAColors.Colors().blue, width: 2) : null
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
    if (points.toString() == 'null' || points == '-1') {
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
