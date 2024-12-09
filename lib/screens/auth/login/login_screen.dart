import 'package:flutter/material.dart';
import 'components/LoginScreenTopImage.dart';
import 'components/background.dart';
import 'components/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginScreenTopImage(),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: LoginForm(),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
    );
  }
}