import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../internationalization/localizations.dart';
import '../../../models/event.dart';
import '../../../models/team.dart';
import '../../../models/user.dart';
import '../../../providers/api.dart';
import '../../widgets/event-list-item.dart';
import '../../widgets/team-list-item.dart';
import '../../widgets/title.dart';

class AccountPage extends StatefulWidget {
  AccountPage();

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {

  FirebaseUser user;
  User userData;
  List<Team> teams;
  List<Event> events;

  TOALocalizations local;
  ThemeData theme;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    User userData = User.fromDataSnapshot(await FirebaseDatabase.instance.reference().child('Users').child(user.uid).once());
//    setState(() {
//      this.user = user;
//      this.userData = userData;
//    });

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
  }

  @override
  Widget build(BuildContext context) {
    local = TOALocalizations.of(context);
    theme = Theme.of(context);

    List<Widget> body = List();

    if (user != null) {
      body.add(Container(
        padding:EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05)
        ),
        child: ListTile(
          leading: (user.displayName?.length ?? -1) > 0 || user.photoUrl != null ? CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl ?? ''),
            child: user.photoUrl == null ? Text(user.displayName.substring(0, 1)) : null,
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
      body.add(Card(
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
      body.add(Card(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets
        )
      ));
    }

    return Scaffold(
      appBar: AppBar(title: Text(local.get('pages.account.title'))),
      body: body.length > 0 ? ListView(
        children: body,
      ) : Center(
        child: CircularProgressIndicator()
      )
    );
  }

  Future<List<Team>> getTeams() async {
    List<Team> teams = List();
    for (String teamKey in userData.favoriteTeams) {
      teams.add(await ApiV3().getTeam(teamKey));
    }
    return teams;
  }

  Future<List<Event>> getEvents() async {
    List<Event> events = List();
    for (String eventKey in userData.favoriteEvents) {
      events.add(await ApiV3().getEvent(eventKey));
    }
    return events;
  }
}
