import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/ui/views/event/EventPage.dart';
import 'package:toa_flutter/ui/widgets/MatchListItem.dart';
import 'package:toa_flutter/providers/ApiV3.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/models/Match.dart';
import 'package:toa_flutter/models/game-specifics/GameData.dart';

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
    if (match.participants == null) {
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
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle titleStyle = textTheme.subhead.copyWith(fontWeight: FontWeight.w600);
    TextStyle subtitleStyle = textTheme.body1.copyWith(fontWeight: FontWeight.w500, color: textTheme.caption.color);

    return Scaffold(
      appBar: AppBar(
        title: match != null && event != null ? Column(
          crossAxisAlignment: isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(match.matchName, style: titleStyle),
            Text(event.getFullName(), style: subtitleStyle)
          ]
        ) : Text('Loading Match...'),

        actions: event != null ? <Widget>[
          PopupMenuButton(
            onSelected: (String value) {
              if (value == 'view_event') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (c) {
                      return EventPage(event);
                    }
                  )
                );
              }
            },
            itemBuilder: (BuildContext c) {
              return [
                PopupMenuItem(
                  value: 'view_event',
                  child: Text('View Full Event'),
                )
              ];
            }
          )
        ] : null
      ),
      body: buildInfo()
    );
  }

  buildInfo() {
    List<Widget> column = [];
    List<Widget> card = [];

    if (match == null) {
      return Center(
        child: CircularProgressIndicator()
      );
    }
    
    // Card title
    card.add(Padding(
      padding: EdgeInsets.only(left: 16, top: 20, bottom: 8, right: 16),
        child: Text(
          'Match Information',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        )
      )
    );

    // Match name
    card.add(ListTile(
      leading: Icon(MdiIcons.informationOutline, color: Theme.of(context).primaryColor),
      title: Text(match.matchName)
    ));

    // Scheduled time
    if (match.scheduledTime != null && match.scheduledTime != '0000-00-00 00:00:00') {
      card.add(ListTile(
        leading: Icon(MdiIcons.calendarClock, color: Theme.of(context).primaryColor),
        title: Text('Scheduled Time: ${DateFormat('MMM d, h:mm a').format(DateTime.parse(match.scheduledTime))}')
      ));
    }

    // Match video
    card.add(ListTile(
      leading: Icon(MdiIcons.playCircleOutline, color: Theme.of(context).primaryColor),
      title: Text(match.videoURL != null ? 'Watch Match' : 'No video available. Add one'),
      onTap: () async {
        final url = match.videoURL != null ? match.videoURL :
          'https://docs.google.com/forms/d/e/1FAIpQLSdpcIpr0uXe0SP5wzdMeVsQ6t3e5ebS5v_C-SDmtOyY2Gu8sw/viewform?entry.944495313=$matchKey';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("An error has occurred"),
          ));
        }
      }
    ));

    // Participants table
    card.add(Padding(
      padding: EdgeInsets.all(8),
      child: MatchListItem(match, justTable: true)
    ));


    // Add the card to the column
    column.add(Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: card
        )
      )
    ));

    // Match breakdown title
    column.add(Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Match Breakdown',
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
      )
    ));

    // Match breakdown
    column.add(!loadingBreakdown ? Column(
      children: GameData.getBreakdown(match)
    ) : Container(
      margin: EdgeInsets.only(top: 36, bottom: 24),
      child: Center(
        child: CircularProgressIndicator()
      )
    ));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: column
      )
    );
  }
}
