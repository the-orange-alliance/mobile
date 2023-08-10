import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../internationalization/localizations.dart';
import '../../../providers/cloud.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    TOALocalizations local = TOALocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    return Scaffold(
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
                    labelText:
                        local.get('pages.account.register.full_name') + '*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String value) {
                    this.name = value;
                  },
                ),
                SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: {email},
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: local.get('pages.account.register.email') + '*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String value) {
                    this.email = value;
                  },
                ),
                SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  autofillHints: {password},
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText:
                        local.get('pages.account.register.password') + '*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (String value) {
                    this.password = value;
                  },
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    style: ElevatedButtonTheme.of(context).style,
                    onPressed: () async {
                      if (this.name.trim().isEmpty ||
                          this.name.trim().length < 3 ||
                          !this.name.trim().contains(' ')) {
                        showSnackbar(
                          context,
                          local.get('pages.account.register.error_name'),
                        );
                      } else {
                        try {
                          UserCredential user = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: this.email,
                                  password: this.password);
                          user.user!.updateDisplayName(this.name);
                          Cloud.initFirebaseMessaging();
                          Navigator.of(context).pop();
                        } on PlatformException catch (e) {
                          showSnackbar(context, e.message!);
                        }
                      }
                    },
                    child: Text(
                      local.get('pages.account.register.sign_up'),
                      style: TextStyle(
                          color: theme.primaryTextTheme.titleLarge!.color),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSnackbar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
