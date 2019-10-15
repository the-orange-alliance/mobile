import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toa_flutter/internationalization/localizations.dart';
import '../../../providers/cloud.dart';
import '../../icon.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    ThemeData theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(local.get('pages.account.login.title'))),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 64),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(TOAIcons.TOA,
                    size: 52,
                    color: isDark ? Colors.white : Colors.black
                  )
                ),
                SizedBox(height: 24),
                Text(
                  local.get('pages.account.login.subtitle'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.subtitle
                ),
                SizedBox(height: 48),
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: local.get('pages.account.login.email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                  onChanged: (String value) {
                    this.email = value;
                  }
                ),
                SizedBox(height: 12),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: local.get('pages.account.login.password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                  onChanged: (String value) {
                    this.password = value;
                  }
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () async {
                      try {
                        FirebaseUser user = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                            email: this.email ?? '',
                            password: this.password ?? ''
                        );
                        Cloud.initFirebaseMessaging();
                        Navigator.of(context).pop();
                      } on PlatformException catch (e) {
                        showSnackbar(e.message);
                      }
                    },
                    padding: EdgeInsets.all(12),
                    color: theme.primaryColor,
                    child: Text(
                      local.get('pages.account.login.login'),
                      style: TextStyle(
                        color: theme.primaryTextTheme.title.color
                      )
                    )
                  )
                )
              ]
            )
          )
        )
      )
    );
  }

  showSnackbar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }
}
