import 'package:flutter/material.dart';
import 'package:uptime_monitor/responsive.dart';
import 'package:uptime_monitor/screens/dashboard/dashboard_screen.dart';
import '../../controllers/MyMenuController.dart';
import 'components/side_menu.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MyMenuController>().scaffoldKey,
      drawer: SideMenu(),
        body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context)) Expanded(
                    child: SideMenu()
                  ),
                  Expanded(
                      flex: 5,
                      child: DashboardScreen(),
                  )
                ]
            )
        )
    );
  }
}


