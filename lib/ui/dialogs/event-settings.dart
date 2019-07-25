import 'package:flutter/material.dart';

import '../../models/EventSettings.dart';

class EventSettingsDialog extends StatefulWidget {
  EventSettingsDialog(this.eventSettings, {Key key}) : super(key: key);

  final EventSettings eventSettings;

  @override
  State<StatefulWidget> createState() => EventSettingsDialogState();
}

class EventSettingsDialogState extends State<EventSettingsDialog> {

  void close(bool save) {
    Navigator.pop(context, save ? widget.eventSettings : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Settings'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => close(false),
        ),
      ),
      body: ListView(
        children: <Widget>[
          CheckboxListTile(
            value: widget.eventSettings.isFavorite,
            title: Text('Favorite'),
            isThreeLine: true,
            subtitle: Text('You can save teams, events, and more for easy access by marking them as favorites.'),
            onChanged: (checked) => setState(() {
              widget.eventSettings.isFavorite = checked;
            }),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Text('Notification Settings', style: Theme.of(context).textTheme.subtitle),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: Text('Subscribing to something lets you get a push notification whenever there is an update.',
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 12)),
          ),
          CheckboxListTile(
            value: widget.eventSettings.matchScored,
            title: Text('Match Scores'),
            onChanged: (checked) => setState(() {
              widget.eventSettings.matchScored = checked;
            }),
          ),
          CheckboxListTile(
            value: widget.eventSettings.scheduleUpdated,
            title: Text('Match Schedule Posted'),
            onChanged: (checked) => setState(() {
              widget.eventSettings.scheduleUpdated = checked;
            }),
          ),
          CheckboxListTile(
            value: widget.eventSettings.alliancesPosted,
            title: Text('Alliance Selections'),
            onChanged: (checked) => setState(() {
              widget.eventSettings.alliancesPosted = checked;
            }),
          ),
          CheckboxListTile(
            value: widget.eventSettings.awardsPosted,
            title: Text('Awards Posted'),
            onChanged: (checked) => setState(() {
              widget.eventSettings.awardsPosted = checked;
            })
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => close(true),
        child: Icon(Icons.done),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
    : super(
    pageBuilder: (context, animation1, animation2) => page,
    transitionsBuilder: (context, animation1, animation2, child) {
      return FadeTransition(opacity: animation1, child: child);
    },
  );
}
