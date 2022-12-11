import 'package:firebase_auth/firebase_auth.dart';
import '../model/local_user.dart';
import 'database_service.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LocalUser _userFromFirebase(User user) {
    return user != null ? (LocalUser(uid: user.uid)) : null;
  }

  Stream<LocalUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password).then((result) async {
        await DatabaseService.instance.createUser(user: LocalUser(uid: result.user.uid));
        return result;
      });
      User user = result?.user;

      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
