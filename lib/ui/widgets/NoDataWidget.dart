import 'package:flutter/material.dart';
import 'package:toa_flutter/models/Event.dart';

class NoDataWidget extends StatelessWidget {

  NoDataWidget(this.iconData, this.text, {this.mini = false});
  final IconData iconData;
  final String text;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(iconData, size: (mini ? 48 : 64), color: Colors.black), // Theme.of(context).primaryColor
          Text(text, textScaleFactor: (mini ? 1 : 1.2), style: TextStyle(fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
