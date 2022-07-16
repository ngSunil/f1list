import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Future<void> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(creds);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential creds = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(creds);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
