import 'package:flutter/material.dart';
import 'package:flutter_project/constants/material_white.dart';
import 'package:flutter_project/models/firebase_auth_state.dart';
import 'package:flutter_project/models/user_model_state.dart';
import 'package:flutter_project/repo/user_network_repository.dart';
import 'package:flutter_project/screens/auth_screen.dart';
import 'package:flutter_project/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
          value: _firebaseAuthState,
        ),
        ChangeNotifierProvider<UserModelState>(
          create: (_) => UserModelState(),
        ),
      ],
      child: MaterialApp(
        home: Consumer<FirebaseAuthState>(builder: (BuildContext context,
            FirebaseAuthState firebaseAuthState, Widget child) {
          switch (firebaseAuthState.firebaseAuthStatus) {
            case FirebaseAuthStatus.signout:
              _clearUserModel(context);
              _currentWidget = AuthScreen();
              break;
            case FirebaseAuthStatus.signin:
              _initUserModel(firebaseAuthState, context);
              _currentWidget = HomePage();
              break;
            default:
              _currentWidget = MyProgressIndicator();
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _currentWidget,
          );
        }),
        theme: ThemeData(primarySwatch: white),
      ),
    );
  }

  void _initUserModel(FirebaseAuthState firebaseAuthState, BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context,listen: false);
    userModelState.currentStreamSub = userNetworkRepository
        .getUserModeStream(firebaseAuthState.firebaseUser.uid)
        .listen((userModel) {
      userModelState.userModel = userModel;
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context,listen: false);
    userModelState.clear();
  }
}
