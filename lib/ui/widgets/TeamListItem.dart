import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Team.dart';
import 'package:toa_flutter/ui/views/team/TeamPage.dart';

class TeamListItem extends StatelessWidget {

  TeamListItem(this.team);
  final Team team;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (c) {
                return new TeamPage(team: team);
              }
            )
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: Text(
                team.teamNumber.toString(),
                textScaleFactor: 1.6,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ),
            Expanded(
              flex: 8,
              child: ListTile(
                title: Text(team.getName(), overflow: TextOverflow.fade, softWrap: false, maxLines: 1, style: TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(team.getFullLocation(), overflow: TextOverflow.fade, softWrap: false, maxLines: 1, style: TextStyle(fontWeight: FontWeight.w500)),
              )
            ),
          ])
        )
      )
    );
  }
}
