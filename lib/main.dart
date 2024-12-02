import 'package:uptime_monitor/constants.dart';
import 'package:uptime_monitor/controllers/MyMenuController.dart';
import 'package:uptime_monitor/screens/dashboard/dashboard_screen.dart';
import 'package:uptime_monitor/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uptime_monitor/screens/site/site_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyMenuController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        routes: {
          '/': (context) => MainScreen(),
          '/site-info': (context) => SiteInfo(),
        },
      ),
    );
  }
}
