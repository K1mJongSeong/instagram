import 'package:flutter/material.dart';
import 'package:flutter_project/constants/common_size.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: common_l_gap,
            ),
            Image.asset('assets/images/insta_text_logo.png'),
            TextFormField(
              controller: _emailController,
              decoration: _textInputDecor('Email'),
              validator: (text) {
                if (text.isNotEmpty && text.contains("@")) {
                  return null;
                } else {
                  return '정확한 이메일 주소를 입력해주세요.';
                }
              },
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            TextFormField(
              controller: _pwController,
              cursorColor: Colors.black54,
              obscureText: true,
              decoration: _textInputDecor('Password'),
              validator: (text) {
                if (text.isNotEmpty && text.length > 5) {
                  return null;
                } else {
                  return '비밀번호를 다시 입력해주세요.';
                }
              },
            ),
            SizedBox(
              height: common_xs_gap,
            ),
            TextFormField(
              controller: _cpwController,
              obscureText: true,
              decoration: _textInputDecor('Confirm Password'),
              validator: (text) {
                if (text.isNotEmpty && _pwController.text == text) {
                  return null;
                } else {
                  return '입력한 아이디 정보가 없습니다.';
                }
              },
            ),
            FlatButton(
              onPressed: () {
                if(_formKey.currentState.validate()){
                  print('Validation success');
                }
              },
              color: Colors.blue,
              child: Text(
                'Join',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _textInputDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
          ),
          borderRadius: BorderRadius.circular(common_s_gap),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
          ),
          borderRadius: BorderRadius.circular(common_s_gap),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300],
          ),
          borderRadius: BorderRadius.circular(common_s_gap),
        ),

        filled: true,
        fillColor: Colors.grey[100]);
  }
}
