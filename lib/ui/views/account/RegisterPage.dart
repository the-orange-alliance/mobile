import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../internationalization/Localizations.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context);
    ThemeData theme = Theme.of(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(local.get('pages.account.register.title'))),
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
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: local.get('pages.account.register.full_name') + '*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onChanged: (String value) {
                    this.name = value;
                  }
                ),
                SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: local.get('pages.account.register.email') + '*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onChanged: (String value) {
                    this.email = value;
                  }),
                SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: local.get('pages.account.register.password') + '*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
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
                      if (this.name.trim().isEmpty ||
                        this.name.trim().length < 3 ||
                        !this.name.trim().contains(' ')) {
                        showSnackbar(local.get('pages.account.register.error_name'));
                      } else {
                        try {
                          FirebaseUser user = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                            email: this.email ?? '',
                            password: this.password ?? '');
                          UserUpdateInfo info = UserUpdateInfo();
                          info.displayName = this.name;
                          user.updateProfile(info);
                          FirebaseDatabase.instance
                            .reference()
                            .child('Users/${user.uid}/fullName')
                            .set(name);
                          Navigator.of(context).pop();
                        } on PlatformException catch (e) {
                          showSnackbar(e.message);
                        }
                      }
                    },
                    padding: EdgeInsets.all(12),
                    color: theme.primaryColor,
                    child: Text(
                      local.get('pages.account.register.sign_up'),
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
