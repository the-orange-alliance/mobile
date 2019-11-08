import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/award-recipient.dart';
import '../views/team/team-page.dart';

class AwardListItem extends StatelessWidget {

  AwardListItem(this.award);
  final AwardRecipient award;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (award.teamKey != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (c) {
                  return TeamPage(teamKey: award.teamKey, team: award.team);
                }
              )
            );
          }
        },
        child: ListTile(
          leading: Icon(getIcon()),
          title: Text(award.award != null ? award.award.awardDescription : award.awardName),
          subtitle: Text(award.receiverName != null ? award.receiverName :'#${award.team.teamNumber} ${award.team.teamNameShort}')
        )
      )
    );
  }

  IconData getIcon() {
    String s = this.award.awardKey.replaceAll(RegExp('\\D+'),''); // Strip all non-numeric characters (get the award number)
    if (s != null  &&  double.parse(s) != null) {
      int awardNum = int.parse(s);
      switch (awardNum) {
        case 0:
          return MdiIcons.numeric0BoxOutline;
        case 1:
          return MdiIcons.numeric1BoxOutline;
        case 2:
          return MdiIcons.numeric2BoxOutline;
        case 3:
          return MdiIcons.numeric3BoxOutline;
        case 4:
          return MdiIcons.numeric4BoxOutline;
        case 5:
          return MdiIcons.numeric5BoxOutline;
      }
    }
    return MdiIcons.trophyOutline;
  }
}
