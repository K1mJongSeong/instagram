import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseUser _firebaseUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void watchAuthChange() {
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context, {@required String email, @required String password}) {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim()).catchError((error) {
      print(error);
      String _message = "";
      switch(error.code){
        case 'ERROR_WEAK_PASSWORD':
          _message = '패스워드 넣으세요';
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = '이메일 주소 잘못';
          break;
        case 'ERROR_ALREADY_IN_USE':
          _message = '이메일 중';
          break;
      }
      SnackBar snackBar = SnackBar(content: Text(_message),);
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void login({@required String email, @required String password}) {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
