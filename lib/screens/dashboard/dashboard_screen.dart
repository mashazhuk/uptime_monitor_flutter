import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptime_monitor/constants.dart';
import 'package:uptime_monitor/models/AllSites.dart';

import 'components/all_sites.dart';
import 'components/header.dart';
import 'components/my_sites.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: defaultPadding * 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      MySites(),
                      SizedBox(height: defaultPadding),
                      AllSites(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}