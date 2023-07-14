import 'package:flutter/material.dart';

import '../../models/team.dart';
import '../views/team/team-page.dart';

class TeamListItem extends StatelessWidget {
  TeamListItem(this.team);

  final Team? team;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (c) {
            return TeamPage(team: team);
          }));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  team!.teamNumber.toString(),
                  textScaleFactor: 1.6,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ),
              Expanded(
                flex: 8,
                child: ListTile(
                  title: Text(team!.getName()!,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w700)
                  ),
                  subtitle: Text(team!.getFullLocation(),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w500)
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
