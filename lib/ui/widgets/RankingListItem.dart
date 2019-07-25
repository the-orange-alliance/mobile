import 'package:flutter/material.dart';

import '../../internationalization/Localizations.dart';
import '../../models/Ranking.dart';
import '../views/team/TeamPage.dart';

class RankingListItem extends StatelessWidget {

  RankingListItem(this.ranking);
  final Ranking ranking;

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);

    String subtitle = '';
    subtitle += ranking.qualifyingPoints > 0 ? '${local.get('pages.event.rankings.qual_points')}: ${ranking.qualifyingPoints}\n' : '';
    subtitle += ranking.rankingPoints    > 0 ? '${local.get('pages.event.rankings.ranking_points')}: ${ranking.rankingPoints}\n' : '';
    subtitle += ranking.tieBreakerPoints > 0 ? '${local.get('pages.event.rankings.tie_beaker_points')}: ${ranking.highestQualScore}\n' : '';
    subtitle += ranking.highestQualScore > 0 ? '${local.get('pages.event.rankings.highest_score')}: ${ranking.highestQualScore}\n' : '';
    subtitle += ranking.opr              > 0 ? 'OPR: ${ranking.opr}\n' : '';
    subtitle += '${local.get('pages.event.rankings.matches_played')}: ${ranking.played}';

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) {
                return TeamPage(teamKey: ranking.teamKey, team: ranking.team);
              }
            )
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: ListTile(
            leading: Column(
              children: <Widget>[
                CircleAvatar(
                  child: Text(ranking.rank.toString()),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('(${ranking.wins}-${ranking.losses}-${ranking.ties})')
                )
              ],
            ),
            title: Text(ranking.team != null ? ranking.team.getNameWithNumber() : '${local.get('general.team')} #${ranking.teamKey}'),
            subtitle: Text(subtitle),
          )
        )
      )
    );
  }
}
