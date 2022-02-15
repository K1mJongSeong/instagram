import 'package:flutter/material.dart';
import 'package:flutter_project/screens/profile_screen.dart';
import 'package:flutter_project/widgets/fade_stack.dart';
import 'package:flutter_project/widgets/sign_in_form.dart';
import 'package:flutter_project/widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {


  int selectedForm =0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FadeStack(
              selectedForm: selectedForm,
            ),
            Container(
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    if(selectedForm == 0){
                      selectedForm =1;
                    }else{
                      selectedForm=0;
                    }
                  });
                },
                child: Text('go to Sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
