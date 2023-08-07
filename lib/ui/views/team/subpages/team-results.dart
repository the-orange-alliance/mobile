import 'dart:async';

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
  List<TeamParticipant>? data;
  TOALocalizations? local;

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);

    return FutureBuilder<List<TeamParticipant>>(
      future: getTeamParticipants(teamKey),
      builder: (BuildContext context,
          AsyncSnapshot<List<TeamParticipant>> teamParticipants) {
        if (teamParticipants.hasData) {
          data = teamParticipants.data;
        }
        return bulidPage();
      },
    );
  }

  Widget bulidPage() {
    if (data != null) {
      if (data!.length > 0) {
        return ListView.builder(
          itemCount: data!.length,
          itemBuilder: (BuildContext context, int index) {
            return bulidItem(data![index]);
          },
        );
      } else {
        return NoDataWidget(
            MdiIcons.calendarOutline, local!.get('no_data.events'));
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget bulidItem(TeamParticipant teamParticipant) {
    List<Widget> card = [];
    List<Match> matches = teamParticipant.matches;

    // Title
    card.add(EventListItem(teamParticipant.event));
    card.add(Divider(height: 0));

    // Ranking
    if (teamParticipant.ranking != null &&
        !teamParticipant.ranking!.rank!.isNaN) {
      card.add(ListTile(
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text: '${local!.get('pages.event.rankings.qual_rank')} '),
              TextSpan(
                text: '#${teamParticipant.ranking!.rank} ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text: '${local!.get('pages.event.rankings.with_record')} '),
              TextSpan(
                text:
                    '${teamParticipant.ranking!.wins}-${teamParticipant.ranking!.losses}-${teamParticipant.ranking!.ties}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ));
    }

    if (matches.length > 0) {
      for (int i = 0; i < matches.length; i++) {
        card.add(MatchListItem(matches[i]));
      }
    } else {
      card.add(Padding(
        padding: EdgeInsets.all(12),
        child: NoDataWidget(
          MdiIcons.gamepadVariant,
          local!.get('no_data.matches'),
          mini: true,
        ),
      ));
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: card,
        ),
      ),
    );
  }

  Future<List<TeamParticipant>> getTeamParticipants(String? teamKey) async {
    List<TeamParticipant> teamParticipants = [];

    // Get all the team's rankings
    final Future<List<Ranking>?> allRankings =
        ApiV3().getTeamResults(teamKey, StaticData.seasonKey);

    final teamEvents = await (ApiV3().getTeamEvents(teamKey, StaticData.seasonKey) as FutureOr<List<EventParticipant>>);

    try {
      teamEvents.sort(Sort.eventParticipantSorter);

      List<Future<void>> requests = [];

      for (final event in teamEvents) {
        EventParticipant eventParticipant = event;
        TeamParticipant teamParticipant = TeamParticipant(event.teamKey, []);

        // Get event detail
        requests.add(ApiV3()
            .getEvent(eventParticipant.eventKey)
            .then((e) => teamParticipant.event = e));

        // Get team matches
        requests.add(
            ApiV3().getEventMatches(eventParticipant.eventKey).then((matches) {
          List<Match> teamMatches = matches
              .where((match) => match.participants!
                  .any((participant) => participant.teamKey == teamKey))
              .toList();

          teamMatches.sort(Sort.matchSorter);
          teamParticipant.matches = teamMatches;
        }));

        // Find the ranking in the event
        requests.add(allRankings.then((rankings) => teamParticipant.ranking =
            rankings!.firstWhere(
                (ranking) => ranking.eventKey == eventParticipant.eventKey)));

        teamParticipants.add(teamParticipant);
      }

      await Future.wait(requests);
    } catch (e) {
      print(e);
    }

    teamParticipants.sort(Sort.teamParticipantSorter);
    return teamParticipants;
  }
}
