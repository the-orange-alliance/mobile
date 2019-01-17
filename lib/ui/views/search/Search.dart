import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toa_flutter/providers/Cache.dart';
import 'package:toa_flutter/ui/widgets/TextListItem.dart';
import 'package:toa_flutter/ui/widgets/EventListItem.dart';
import 'package:toa_flutter/ui/widgets/TeamListItem.dart';
import 'package:toa_flutter/models/Event.dart';
import 'package:toa_flutter/models/Team.dart';
import 'package:toa_flutter/Sort.dart';
import 'package:toa_flutter/internationalization/Localizations.dart';

class SearchPage extends StatefulWidget {

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  String query = '';
  TextEditingController queryTextController = TextEditingController();

  List<Event> allEvents = [];
  List<Team> allTeams = [];

  List<Widget> results = [];

  TOALocalizations local;

  @override
  void initState() {
    super.initState();

    // Load events and teams
    loadData();

    // Start listening to changes
    queryTextController.addListener(() {
      query = queryTextController.text;
      setState(() {
        search();
      });
    });
  }

  Future<void> loadData() async {
    // Load events
    var events = await Cache().getEvents();
    setState(() {
      allEvents = events;
      allEvents.sort(Sort().eventSorter);
      search();
    });

    // Load teams
    var teams = await Cache().getTeams();
    setState(() {
      allTeams = teams;
      allTeams.sort(Sort().teamSorter);
      search();
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget content;
    local = TOALocalizations.of(context);

    if (allEvents.isEmpty || allTeams.isEmpty) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      content = ListView.separated(
        itemCount: results.length,
        separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
        itemBuilder: (BuildContext context, int index) {
          return results[index];
        }
      );
    }


    List<Widget> actions = [];
    if (query.isNotEmpty) {
      actions.add(IconButton(
        tooltip: local.get('general.clear'),
        icon: const Icon(Icons.clear),
        onPressed: () {
          queryTextController.text = '';
        }
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: queryTextController,
          style: Theme.of(context).textTheme.title,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: MaterialLocalizations.of(context).searchFieldLabel,
          ),
        ),
        actions: actions,
      ),
      body: content
    );
  }

  search() {
    results.clear();

    if (query.isNotEmpty) {
      List<Widget> events = [];
      List<Widget> teams = [];

      results.add(TextListItem(local.get('general.teams')));
      for (int i = 0; i < allTeams.length; i++) {
        Team team = allTeams[i];
        if (team.teamNumber.toString().startsWith(query)
            || (team.teamNameShort != null && team.teamNameShort.toLowerCase().startsWith(query.toLowerCase()))) {
          teams.add(TeamListItem(team));
        }
      }
      if (teams.length > 0) {
        results.addAll(teams);
      } else {
        results.add(TextListItem(local.get('no_data.teams'), mini: true));
      }

      results.add(TextListItem(local.get('general.events')));
      for (int i = 0; i < allEvents.length; i++) {
        Event event = allEvents[i];
        if (event.getFullName().toLowerCase().contains(query.toLowerCase())
            || (event.eventKey.toLowerCase() == query.toLowerCase())) {
          events.add(EventListItem(event));
        }
      }
      if (events.length > 0) {
        results.addAll(events);
      } else {
        results.add(TextListItem(local.get('no_data.events'), mini: true));
      }
    }
  }
}
