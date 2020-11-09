import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../internationalization/localizations.dart';
import '../../../models/event.dart';
import '../../../models/team.dart';
import '../../../models/user.dart';
import '../../../providers/api.dart';
import '../../../providers/cloud.dart';
import '../../widgets/event-list-item.dart';
import '../../widgets/team-list-item.dart';
import '../../widgets/title.dart';

class AccountPage extends StatefulWidget {
  AccountPage();

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {

  TOAUser user;
  List<Team> teams;
  List<Event> events;

  TOALocalizations local;
  ThemeData theme;

  @override
  void initState() {
    super.initState();
    Cloud.getUser().then((TOAUser user) {
      setState(() {
        this.user = user;
      });
      getTeams().then((List<Team> teams) {
        setState(() {
          this.teams = teams;
        });
      });

      getEvents().then((List<Event> events) {
        setState(() {
          this.events = events;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);
    theme = Theme.of(context);

    List<Widget> body = List();
    List<Widget> favorites = List();

    if (user != null) {
      body.add(Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05)
        ),
        child: ListTile(
          leading: user.photoURL != null || (user.displayName != null && user.displayName.length > 1) ? CircleAvatar(
            backgroundImage: user.photoURL != null ? NetworkImage(user.photoURL) : null,
            child: user.photoURL == null ? Text(user.displayName.substring(0, 1)) : null,
            radius: 16,
          ) : null,
          title: Text(user.displayName ?? 'TOA User'),
          subtitle: Text(user.email),
          trailing: IconButton(
            icon: Icon(MdiIcons.logout),
            tooltip: local.get('pages.account.logout'),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            }
          )
        )
      ));
    }

    if (teams != null && teams.length > 0) {
      List<Widget> widgets = [
        TOATitle(local.get('general.teams'), context)
      ];
      widgets.addAll(teams.map((team) => TeamListItem(team)).toList());
      favorites.add(Card(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets
        )
      ));
    }

    if (events != null && events.length > 0) {
      List<Widget> widgets = [
        TOATitle(local.get('general.events'), context)
      ];
      widgets.addAll(events.map((event) => EventListItem(event)).toList());
      favorites.add(Card(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets
        )
      ));
    }

    if (favorites.length == 0) {
      body.add(Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        )
      ));
    } else {
      body.add(Expanded(
        child: ListView(
          children: favorites
        )
      ));
    }

    return Scaffold(
      appBar: AppBar(title: Text(local.get('pages.account.title'))),
      body: body.length > 0 ? Column(
        children: body
      ) : Center(
        child: CircularProgressIndicator()
      )
    );
  }

  Future<List<Team>> getTeams() {
    return Future.wait(user.favoriteTeams.map((teamKey) => ApiV3().getTeam(teamKey)));
  }

  Future<List<Event>> getEvents() {
    return Future.wait(user.favoriteEvents.map((eventKey) => ApiV3().getEvent(eventKey)));
  }
}
