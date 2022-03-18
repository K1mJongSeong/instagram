import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAuthState extends ChangeNotifier{
  FirebaseAuthStatus _firebaseAuthStatus =FirebaseAuthStatus.progress;
  FirebaseUser _firebaseUser;
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  void watchAuthChange(){
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if(firebaseUser == null && _firebaseUser == null){
        return;
      }else if(firebaseUser != _firebaseUser){
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]){
    if(firebaseAuthStatus != null){
      _firebaseAuthStatus = firebaseAuthStatus;
    }else{
      if(_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      }else{
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }
  FirebaseAuthStatus get firebaseAuthStatus=>_firebaseAuthStatus;
}

enum FirebaseAuthStatus{
  signout, progress, signin
}