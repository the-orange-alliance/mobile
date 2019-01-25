import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/ui/Colors.dart' as TOAColors;
import 'package:toa_flutter/providers/StaticData.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/models/Team.dart';
import 'package:toa_flutter/models/TeamSeasonRecord.dart';
import 'package:toa_flutter/ui/views/team/subpages/TeamResults.dart';
import 'package:toa_flutter/ui/views/team/subpages/TeamRobot.dart';
import 'package:toa_flutter/internationalization/Localizations.dart';

class TeamPage extends StatefulWidget {
  TeamPage({this.teamKey, this.team});

  final String teamKey;
  final Team team;

  @override
  TeamPageState createState() => new TeamPageState();
}

class TeamPageState extends State<TeamPage> with TickerProviderStateMixin {

  String teamKey;
  Team team;
  TOALocalizations local;
  ThemeData theme;

  @override
  void initState() {
    super.initState();
    teamKey = widget.teamKey;
    team = widget.team;

    if (widget.team != null) {
      teamKey = widget.team.teamKey;
    }

    loadData();
  }

  Future<void> loadData() async {
    Team team = this.team;

    if (team == null) {
      team = await ApiV3().getTeam(teamKey);
    }

    setState(() {
      this.team = team;
    });
  }

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);
    theme = Theme.of(context);

    TeamResults teamResults = TeamResults(teamKey);
    TeamRobot teamRobot = TeamRobot(teamKey);

    var linearGradient = BoxDecoration(
      gradient: LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          TOAColors.Colors().toaColors.shade400,
          TOAColors.Colors().toaColors.shade600
        ],
      ),
    );

    if (theme.brightness == Brightness.dark) {
      linearGradient = BoxDecoration(color: theme.primaryColor);
    }

    return DefaultTabController(
      length: 2,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: linearGradient,
            height: 200,
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('${team != null && team.teamNameShort != null ? team.teamNameShort : 'Team'} #${team?.teamNumber ?? teamKey}'),
              backgroundColor: Colors.transparent,
              elevation: 0
            ),
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: linearGradient,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildAppbar(teamKey, context),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TabBar(
                          tabs: [
                            Tab(text: local.get('pages.team.results.title')),
                            Tab(text: local.get('pages.team.robot_profile.title'))
                          ],
                          indicatorColor: theme.brightness == Brightness.light ? Colors.black : Colors.white,
                        )
                      )
                    ]
                  )
                ),
                Expanded(
                  child: Container(
                    color: theme.scaffoldBackgroundColor,
                    child: TabBarView(
                      children: [
                        teamResults,
                        teamRobot
                      ]
                    )
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }

  Widget buildAppbar(String teamKey, BuildContext context) {
    if (team != null) {
      return buildInfo(team, context);
    } else {
      return Center(
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(theme.brightness == Brightness.light ? Colors.black : Colors.white))
      );
    }
  }

  Widget buildInfo(Team team, BuildContext context) {
    return FutureBuilder<TeamSeasonRecord>(
      future: ApiV3().getTeamWLT(teamKey, StaticData().sessonKey),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot<TeamSeasonRecord> wlt) {
        List<Widget> details = [
          buildTeamDetail(MdiIcons.mapMarkerOutline, team.getFullLocation()),
          buildTeamDetail(MdiIcons.compassOutline, '${team.regionKey} Region'),
          buildTeamDetail(MdiIcons.airballoon, '${local.get('pages.team.rookie_year')}: ${team.rookieYear}')
        ];

        if (wlt.data != null) {
          TeamSeasonRecord record = wlt.data;
          details.add(buildTeamDetail(MdiIcons.flagOutline, '${record.wins}-${record.losses}-${record.ties} WLT'));
        }

        return Wrap(
          spacing: 20,
          runSpacing: 4,
          children: details
        );
      }
    );
  }

  Widget buildTeamDetail(IconData icon, String text) {
    Color color = theme.brightness == Brightness.light ? Color(0xBB000000) : Color(0xD9FFFFFF);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 16),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(text, style: Theme.of(context).textTheme.subhead.copyWith(color: color))
          )
        ]
      )
    );
  }
}
