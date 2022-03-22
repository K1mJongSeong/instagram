import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  void registerUser({@required String email, @required String password}) {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password).catchError((error) {
      print(error);
      String _message = "";
      // swtich(error.code){
      // case 'ERROR_WEAK_PASSWORD':
      // _message="패스워드를 넣어주세";
      // break;
      // case 'ERROR_INVAILD_EMAIL':;
      // _message="이메일 주";
      // break;
      // case 'ERROR_EMAIL_ALEADY_IN_USE':
      // _message="해당 이메일 중";
      // break;
      // }

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
