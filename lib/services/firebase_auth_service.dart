import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      // Giriş başarısız oldu
      if (kDebugMode) {
        print('Giriş başarisiz: $e');
      }
      return null;
    }
  }

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      // Kayıt başarısız oldu
      if (kDebugMode) {
        print('Kayit başarisiz: $e');
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
