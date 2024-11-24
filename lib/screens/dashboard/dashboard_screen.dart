import 'package:flutter/material.dart';
import 'package:uptime_monitor/constants.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                  Text(
                    "Dashboard",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: secondaryColor,
                      filled: true
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}