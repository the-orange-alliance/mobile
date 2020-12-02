import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../internationalization/localizations.dart';
import '../../../models/event.dart';
import '../../../models/match.dart';
import '../../../models/game-specifics/game-data.dart';
import '../../../providers/api.dart';
import '../../widgets/match-list-item.dart';
import '../../widgets/title.dart';
import '../event/event-page.dart';

class MatchPage extends StatefulWidget {
  MatchPage({this.matchKey, this.match, this.event});

  final String matchKey;
  final Match match;
  final Event event;

  @override
  MatchPageState createState() => new MatchPageState();
}

class MatchPageState extends State<MatchPage> {
  String matchKey;
  Match match;
  Event event;
  bool loadingBreakdown = true;
  TOALocalizations local;
  ThemeData theme;

  @override
  void initState() {
    super.initState();
    match = widget.match;
    event = widget.event;

    if (widget.match != null) {
      matchKey = widget.match.matchKey;
    } else {
      matchKey = widget.matchKey;
    }

    loadData();
  }

  Future<void> loadData() async {
    Match match = this.match;
    Event event = this.event;

    if (match == null) {
      match = await ApiV3().getMatch(matchKey);
    }
    if (match.participants == null || match.participants.length == 0) {
      match.participants = await ApiV3().getMatchParticipants(matchKey);
    }
    if (match.gameData == null) {
      loadingBreakdown = true;
      match.gameData = await ApiV3().getMatchGameData(matchKey);
    }

    if (event == null) {
      event = await ApiV3().getEvent(match.eventKey);
    }

    setState(() {
      this.match = match;
      this.event = event;
      this.loadingBreakdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);
    theme = Theme.of(context);

    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    TextTheme textTheme = theme.textTheme;
    TextStyle titleStyle =
    textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600);
    TextStyle subtitleStyle = textTheme.bodyText2
        .copyWith(fontWeight: FontWeight.w500, color: textTheme.caption.color);

    return Scaffold(
        appBar: AppBar(
            title: match != null && event != null
                ? Column(
                crossAxisAlignment: isIOS
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(match.matchName, style: titleStyle),
                  Text(event.getFullName(), style: subtitleStyle)
                ])
                : Text(local.get('pages.match.loading')),
            actions: event != null
                ? <Widget>[
              PopupMenuButton(onSelected: (String value) {
                if (value == 'view_event') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) {
                    return EventPage(event);
                  }));
                }
              }, itemBuilder: (BuildContext c) {
                return [
                  PopupMenuItem(
                    value: 'view_event',
                    child: Text(local.get('pages.match.full_event')),
                  )
                ];
              })
            ]
                : null),
        body: buildInfo());
  }

  buildInfo() {
    List<Widget> column = [];
    List<Widget> card = [];

    if (this.match == null) {
      return Center(child: CircularProgressIndicator());
    }

    // Card title
    card.add(TOATitle(local.get('pages.match.match_info'), context));

    // Scheduled time
    if (this.match.scheduledTime != null &&
        this.match.scheduledTime != '0000-00-00 00:00:00' &&
        this.match.redScore <= 0 && this.match.blueScore <= 0
    ) {
      card.add(ListTile(
          leading: Icon(MdiIcons.calendarClock,
              color: Theme.of(context).primaryColor),
          title: Text(DateFormat('MMM d, h:mm a')
              .format(DateTime.parse(match.scheduledTime).toLocal())),
          subtitle: Text(local.get('pages.match.scheduled_time'))));
    }

    // Match video
    card.add(ListTile(
        leading: Icon(MdiIcons.playCircleOutline,
            color: Theme.of(context).primaryColor),
        title: Text(local.get(
            'pages.match.${match.videoURL != null ? 'watch_match' : 'no_video'}')),
        onTap: () async {
          final url = match.videoURL != null
              ? match.videoURL
              : 'https://docs.google.com/forms/d/e/1FAIpQLSdpcIpr0uXe0SP5wzdMeVsQ6t3e5ebS5v_C-SDmtOyY2Gu8sw/viewform?entry.944495313=$matchKey';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(local.get('general.error_occurred')),
            ));
          }
        }));

    // Participants table
    card.add(Padding(
        padding: EdgeInsets.all(8),
        child: MatchListItem(match, justTable: true)));

    // Add the card to the column
    column.add(Padding(
        padding: EdgeInsets.all(8),
        child: Card(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: card)
        )
    ));

    // Match breakdown title
    column.add(Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          local.get('pages.match.match_breakdown'),
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: theme.primaryTextTheme.headline6.color),
        )));

    // Match breakdown
    column.add(!loadingBreakdown
        ? Column(children: GameData.getBreakdown(match, context, match.participants.length == 1))
        : Container(
        margin: EdgeInsets.only(top: 36, bottom: 24),
        child: Center(child: CircularProgressIndicator())));
    column.add(Padding(padding: EdgeInsets.only(top: 25)));

    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: column));
  }
}
