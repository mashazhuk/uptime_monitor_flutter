import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 1,
              child: Image.asset("assets/icons/user-login.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
        const Text(
          "Uptime monitor",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25 ),
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}