import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptime_monitor/constants.dart';
import 'package:uptime_monitor/models/AllSites.dart';


import 'components/all_sites.dart';
import 'components/header.dart';
import 'components/my_sites.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              ),
            ],
          ),
        ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: primaryColor,
      onPressed: () {
      Navigator.of(context).pushNamed("/add-site");
      },
      child: const Icon(Icons.add),
    ),
    );
  }
}