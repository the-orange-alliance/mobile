import 'package:flutter/material.dart';

import '../../../sort.dart';
import '../../../internationalization/localizations.dart';
import '../../../models/event.dart';
import '../../../models/team.dart';
import '../../../providers/cache.dart';
import '../../../ui/widgets/event-list-item.dart';
import '../../../ui/widgets/team-list-item.dart';
import '../../../ui/widgets/text-list-item.dart';

class SearchPage extends StatefulWidget {

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  String query = '';
  TextEditingController queryTextController = TextEditingController();

  List<Event>? allEvents = [];
  List<Team>? allTeams = [];

  List<Widget> results = [];

  TOALocalizations? local;

  @override
  void initState() {
    super.initState();

    // Load events and teams
    Cache().getEvents().then((List<Event>? events) {
      setState(() {
        allEvents = events;
        allEvents!.sort(Sort().eventSorter);
        search();
      });
    });
    Cache().getTeams().then((List<Team>? teams) {
      setState(() {
        allTeams = teams;
        allTeams!.sort(Sort().teamSorter);
        search();
      });
    });

    // Start listening to changes
    queryTextController.addListener(() {
      query = queryTextController.text;
      setState(() {
        search();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    local = TOALocalizations.of(context);

    if (results.length <= 4 && (allEvents!.isEmpty || allTeams!.isEmpty)) {
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
        tooltip: local!.get('general.clear'),
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
          style: Theme.of(context).textTheme.headline6,
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

      results.add(TextListItem(local!.get('general.teams')));
      for (int i = 0; i < allTeams!.length; i++) {
        Team team = allTeams![i];
        if (team.teamNumber.toString().startsWith(query)
            || (team.teamNameShort != null && team.teamNameShort!.toLowerCase().startsWith(query.toLowerCase()))) {
          teams.add(TeamListItem(team));
        }
      }
      if (teams.length > 0) {
        results.addAll(teams);
      } else {
        results.add(TextListItem(local!.get('no_data.teams'), mini: true));
      }

      results.add(TextListItem(local!.get('general.events')));
      for (int i = 0; i < allEvents!.length; i++) {
        Event event = allEvents![i];
        if (event.getFullName().toLowerCase().contains(query.toLowerCase())
            || (event.eventKey!.toLowerCase() == query.toLowerCase())) {
          events.add(EventListItem(event));
        }
      }
      if (events.length > 0) {
        results.addAll(events);
      } else {
        results.add(TextListItem(local!.get('no_data.events'), mini: true));
      }
    }
  }
}
