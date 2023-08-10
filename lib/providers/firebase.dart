import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  Future<String?> getUID() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }
}