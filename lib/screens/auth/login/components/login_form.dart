import 'package:flutter/material.dart';

import '../../../../constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              labelText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                labelText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical: defaultPadding,
                ),
              ),
              onPressed: () {},
              label: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don’t have an Account? ",
            style: const TextStyle(color: primaryColor),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Sign Up",
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      )
          // AlreadyHaveAnAccountCheck(
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return const SignUpScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}