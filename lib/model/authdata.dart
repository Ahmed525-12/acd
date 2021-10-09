import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? uid;
  String? token;
  Future<void> signUp(String email, String password) async {
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    uid = user.user!.uid;
    token = await user.user!.getIdToken();
  }

  Future<void> logIn(String email, String password) async {
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    uid = user.user!.uid;
    token = await user.user!.getIdToken();

    notifyListeners();
  }

  void logOut() {
    uid = null;
    token = null;
    notifyListeners();
  }

  Future<void> getDataFromsPref() async {
    var sPref = await SharedPreferences.getInstance();

    uid = sPref.getString('uid');
    token = sPref.getString('token');
  }
}
