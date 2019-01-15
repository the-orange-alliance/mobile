import 'package:flutter/material.dart';
import 'package:toa_flutter/ui/views/team/TeamPage.dart';
import 'package:toa_flutter/models/Ranking.dart';

class RankingListItem extends StatelessWidget {

  RankingListItem(this.ranking);
  final Ranking ranking;

  @override
  Widget build(BuildContext context) {
    String subtitle = '';
    subtitle += ranking.qualifyingPoints > 0 ? 'Qualification Points: ${ranking.qualifyingPoints}\n' : '';
    subtitle += ranking.rankingPoints > 0 ? 'Ranking Points: ${ranking.rankingPoints}\n' : '';
    subtitle += ranking.tieBreakerPoints > 0 ? 'Tie Breaker Points: ${ranking.highestQualScore}\n' : '';
    subtitle += ranking.highestQualScore > 0 ? 'Highest Score: ${ranking.highestQualScore}\n' : '';
    subtitle += 'Matches Played: ${ranking.played}';

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
            title: Text('Team #${ranking.teamKey}'),
            subtitle: Text(subtitle),
          )
        )
      )
    );
  }
}
