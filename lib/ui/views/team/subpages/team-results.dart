import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../sort.dart';
import '../../../../internationalization/localizations.dart';
import '../../../../models/event-participant.dart';
import '../../../../models/match.dart';
import '../../../../models/ranking.dart';
import '../../../../models/team-participant.dart';
import '../../../../providers/api.dart';
import '../../../../providers/static-data.dart';
import '../../../widgets/event-list-item.dart';
import '../../../widgets/match-list-item.dart';
import '../../../widgets/no-data-widget.dart';

class TeamResults extends StatelessWidget {

  TeamResults(this.teamKey);

  final String teamKey;
  List<TeamParticipant> data;
  TOALocalizations local;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

    return FutureBuilder<List<TeamParticipant>>(
      future: getTeamParticipants(teamKey),
      builder: (BuildContext context, AsyncSnapshot<List<TeamParticipant>> teamParticipants) {
        if (teamParticipants.data != null) {
          data = teamParticipants.data;
        }
        return bulidPage();
      }
    );
  }

  Widget bulidPage() {
    if (data != null) {
      if (data.length > 0) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return bulidItem(data[index]);
          }
        );
      } else {
        return NoDataWidget(MdiIcons.calendarOutline, local.get('no_data.events'));
      }
    } else {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  }

  Widget bulidItem(TeamParticipant teamParticipant) {
    List<Widget> card = [];
    List<Match> matches = teamParticipant.matches;

    // Title
    card.add(EventListItem(teamParticipant.event));
    card.add(Divider(height: 0));

    // Ranking
    if (teamParticipant.ranking != null && !teamParticipant.ranking.rank.isNaN) {
      card.add(ListTile(
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text: '${local.get('pages.event.rankings.qual_rank')} '),
              TextSpan(text: '#${teamParticipant.ranking.rank} ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '${local.get('pages.event.rankings.with_record')} '),
              TextSpan(text: '${teamParticipant.ranking.wins}-${teamParticipant.ranking.losses}-${teamParticipant.ranking.ties}', style: TextStyle(fontWeight: FontWeight.bold)),
            ]
          )
        )
      ));
    }

    if (matches.length > 0) {
      for (int i = 0; i < matches.length; i++) {
        card.add(MatchListItem(matches[i]));
      }
    } else {
      card.add(Padding(
        padding: EdgeInsets.all(12),
        child: NoDataWidget(MdiIcons.gamepadVariant, local.get('no_data.matches'), mini: true)
      ));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: card
        )
      )
    );
  }

  Future<List<TeamParticipant>> getTeamParticipants(String teamKey) async {
    List<TeamParticipant> teamParticipants = [];

    // Get all the team's rankings
    List<Ranking> allRankings = await ApiV3().getTeamResults(teamKey, StaticData().seasonKey);

    await ApiV3().getTeamEvents(teamKey, StaticData().seasonKey).then((events) async {
      events.sort(Sort().eventParticipantSorter);

      for (int i = 0; i < events.length; i++) {
        EventParticipant eventParticipant = events[i];
        TeamParticipant teamParticipant = TeamParticipant();

        // Get event detail
        teamParticipant.event = await ApiV3().getEvent(eventParticipant.eventKey);

        // Get team matches
        List<Match> teamMatches = [];
        await ApiV3().getEventMatches(eventParticipant.eventKey).then((matches) {
          for (int i = 0; i < matches.length; i++) {
            Match match = matches[i];
            for (int i = 0; i < match.participants.length; i++) {
              if (match.participants[i].teamKey == teamKey) {
                teamMatches.add(match);
                break;
              }
            }
          }
        });
        teamMatches.sort(Sort().matchSorter);
        teamParticipant.matches = teamMatches;

        // Find the ranking in the event
        for (int i = 0; i < allRankings.length; i++) {
          Ranking ranking = allRankings[i];
          if (ranking.eventKey == eventParticipant.eventKey) {
            teamParticipant.ranking = ranking;
            break;
          }
        }

        teamParticipants.add(teamParticipant);
      }
    }).catchError(print);
    teamParticipants.sort(Sort().teamParticipantSorter);
    return teamParticipants;
  }
}
