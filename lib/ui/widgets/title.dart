import 'package:flutter/material.dart';

class TOATitle extends StatelessWidget {
  TOATitle(this.title, this.context);

  final String title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 20, bottom: 8, right: 16),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryTextTheme.headline6.color
        )
      ),
    );
  }
}
