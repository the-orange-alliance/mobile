import 'package:flutter/material.dart';
import 'package:toa_flutter/ui/Colors.dart' as TOAColors;
import 'package:toa_flutter/ui/views/events/EventsListPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // Root widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Orange Alliance',
      theme: ThemeData(
        primarySwatch: new TOAColors.Colors().toaColors,
        fontFamily: 'GoogleSans',
      ),
      home: EventsListPage(),
    );
  }
}