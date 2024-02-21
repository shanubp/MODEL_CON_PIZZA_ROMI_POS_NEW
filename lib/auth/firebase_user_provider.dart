
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DhaboEcommerceFirebaseUser {
  DhaboEcommerceFirebaseUser(this.user);
  final User? user;
  bool get loggedIn => user != null;
}

DhaboEcommerceFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DhaboEcommerceFirebaseUser> dhaboEcommerceFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
        .map<DhaboEcommerceFirebaseUser>(
            (user) => currentUser = DhaboEcommerceFirebaseUser(user));

