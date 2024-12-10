import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptime_monitor/constants.dart';
import 'package:uptime_monitor/controllers/MyMenuController.dart';
import 'package:uptime_monitor/screens/auth/login/login_screen.dart';
import 'package:uptime_monitor/screens/dashboard/dashboard_screen.dart';
import 'package:uptime_monitor/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uptime_monitor/screens/site/site_info.dart';

import 'screens/site/add_site.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('authToken');
  runApp(MyApp(
    isAuthenticated: token != null,
  ));
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  const MyApp({Key? key, required this.isAuthenticated}) : super(key: key);

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
        initialRoute: isAuthenticated ? '/' : '/login',
        onGenerateRoute: (settings) {
          if (settings.name != null && settings.name!.startsWith('/site-info/')) {
            final siteId = int.parse(settings.name!.split('/').last);
            return MaterialPageRoute( builder: (context) {
              return SiteInfo(siteId: siteId); },
            );
          }
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => MainScreen());
            case '/add-site':
              return MaterialPageRoute(builder: (context) => AddSite());
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginScreen());
            default:
              return null;
          }
            // '/': (context) => MainScreen(),
            // '/site-info/:siteId': (context) => SiteInfo(),
            // '/add-site': (context) => AddSite(),
            // '/login': (context) => LoginScreen(),
          },
      ),
    );
  }
}
