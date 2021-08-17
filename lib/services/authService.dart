import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthtastic/models/baseUserModel.dart';
import 'package:healthtastic/services/database.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Future signInWithEmailPassword({required String email, required String password, String? error}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      _userFromFirebaseUser(user!);
      return 'SignedIn';
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      error = e.message;
      return null;
    }
  }

  Future registerWithEmailPasswordStudent({
    String? email,
    String? password,
    String? name,
    String? aadar,
    String? role,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
      await UserHelper(uid: result.user!.uid).addUserRegisToFirebase(name!, email, aadar!, result.user!.uid, role!);
      // add role to firebase
      return 'SignedUp';
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  static signout() {
    return _auth.signOut();
  }
}
