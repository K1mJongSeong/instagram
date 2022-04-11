import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_project/repo/user_network_repository.dart';
import 'package:flutter_project/utills/simple_snackbar.dart';
import 'package:path/path.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseUser _firebaseUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin;

  void watchAuthChange() {
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        changeFirebaseAuthStatus();
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context,
      {@required String email, @required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    AuthResult authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
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
      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if (_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text("Please try again later"),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      //TODO: send data to firestore
      await userNetworkRepository.attemptCreateUser(
          userKey: _firebaseUser.uid, email: _firebaseUser.email);
    }
  }

  void login(BuildContext context,
      {@required String email, @required String password}) {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          _message = '패스워드가 잘못 됐습니다.';
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = '이메일 주소 잘못';
          break;
        case 'ERROR_USER_NOT_FOUND':
          _message = '유저를 찾지 못했습니다.';
          break;
        case 'ERROR_USER_DISABLED':
          _message = '해당 유저는 금지';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          _message = '나중에 다시 시도 하세';
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          _message = '해당 동작은 금지입니다.';
          break;
      }
      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      await _firebaseAuth.signOut();
      if (await _facebookLogin.isLoggedIn) {
        await _facebookLogin.logOut();
      }
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

  void loginWithFacebook(BuildContext context) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    if (_facebookLogin == null) _facebookLogin = FacebookLogin();
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _handleFacebookTokenWithFirebase(context, result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        simpleSnackbar(context, 'User cancel facebook sign in');
        break;
      case FacebookLoginStatus.error:
        simpleSnackbar(context, '페이스북 로그인 에');
        break;
    }
  }

  void _handleFacebookTokenWithFirebase(
      BuildContext context, String token) async {
    //TODO: 토큰을 사용해서 파이어베이스로 로그인하기.
    final AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token);

    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    if (user == null) {
      simpleSnackbar(context, '페이스북 로그인이 실패 나중에 다시 시도하세요.');
    } else {
      _firebaseUser = user;
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
  FirebaseUser get firebaseUser => _firebaseUser;
}

enum FirebaseAuthStatus { signout, progress, signin }
