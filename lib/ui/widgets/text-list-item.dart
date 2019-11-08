import 'package:flutter/material.dart';

class TextListItem extends StatelessWidget {
  TextListItem(this.title, {this.mini = false});

  final String title;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      child: Text(
        title,
        textScaleFactor: mini ? 1.3 : 1.8,
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: mini ? FontWeight.w400 : FontWeight.w500),
      ),
    );
  }
}
