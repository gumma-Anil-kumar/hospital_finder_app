import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<User?> signUpWithEmailPassword(String email, String password) async {
    final userCred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCred.user;
  }

  static Future<User?> signInWithEmailPassword(String email, String password) async {
    final userCred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCred.user;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
