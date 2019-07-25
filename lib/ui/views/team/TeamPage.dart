import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import './subpages/TeamResults.dart';
import './subpages/TeamRobot.dart';
import '../../../internationalization/Localizations.dart';
import '../../../models/Team.dart';
import '../../../models/TeamSeasonRecord.dart';
import '../../../providers/ApiV3.dart';
import '../../../providers/Firebase.dart';
import '../../../providers/StaticData.dart';
import '../../Colors.dart' as TOAColors;

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

  bool firebaseConnected = false;
  bool isFav = false;

  TeamResults teamResults;
  TeamRobot teamRobot;
  TeamSeasonRecord record;

  @override
  void initState() {
    super.initState();
    teamKey = widget.teamKey;
    team = widget.team;

    if (widget.team != null) {
      teamKey = widget.team.teamKey;
    }

    teamResults = TeamResults(teamKey);
    teamRobot = TeamRobot(teamKey);

    loadData();
    loadUser();
  }

  Future<void> loadData() async {
    Team team = this.team;

    if (team == null) {
      team = await ApiV3().getTeam(teamKey);
    }

    TeamSeasonRecord record = await ApiV3().getTeamWLT(teamKey, StaticData().sessonKey);

    setState(() {
      this.record = record;
      this.team = team;
    });
  }

  Future<void> loadUser() async {
    String uid = await Firebase().getUID();
    bool isFav = false; // TODO: Get the real state
    setState(() {
      this.isFav = isFav;
      this.firebaseConnected = uid != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);
    theme = Theme.of(context);

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
              title: Text('${team != null && team.teamNameShort != null ? team.teamNameShort : 'Team'} #${team?.teamNumber ?? teamKey}', overflow: TextOverflow.fade),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                firebaseConnected && isFav ? IconButton(
                  icon: Icon(MdiIcons.star),
                  tooltip: local.get('general.remove_from_mytoa'),
                  onPressed: () {
                    // TODO: Remove from myTOA
                    setState(() {});
                  }
                ) : null,
                firebaseConnected && !isFav ? IconButton(
                  icon: Icon(MdiIcons.starOutline),
                  tooltip: local.get('general.add_to_mytoa'),
                  onPressed: () {
                    // TODO: Add from myTOA
                    setState(() {});
                  }
                ) : null
              ].where((o) => o != null).toList(),
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
    List<Widget> details = [
      buildTeamDetail(MdiIcons.mapMarkerOutline, team.getFullLocation()),
      buildTeamDetail(MdiIcons.compassOutline, '${team.regionKey} Region'),
      buildTeamDetail(MdiIcons.airballoon, '${local.get('pages.team.rookie_year')}: ${team.rookieYear}')
    ];

    if (record != null) {
      details.add(buildTeamDetail(MdiIcons.flagOutline, '${record.wins}-${record.losses}-${record.ties} WLT'));
    }

    return Wrap(
      spacing: 20,
      runSpacing: 4,
      children: details
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
