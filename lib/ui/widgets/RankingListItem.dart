import 'package:flutter/material.dart';
import 'package:toa_flutter/ui/views/team/TeamPage.dart';
import 'package:toa_flutter/models/Ranking.dart';
import 'package:toa_flutter/internationalization/Localizations.dart';

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
    subtitle += '${local.get('pages.event.rankings.matches_played')}: ${ranking.played}';

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) {
                return TeamPage(teamKey: ranking.teamKey);
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
            title: Text('${local.get('general.team')} #${ranking.teamKey}'),
            subtitle: Text(subtitle),
          )
        )
      )
    );
  }
}
