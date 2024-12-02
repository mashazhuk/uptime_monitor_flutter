import 'package:flutter/material.dart';

import '../../models/AllSites.dart';

class SiteInfo extends StatelessWidget {
  const SiteInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final AllSite siteInfo = ModalRoute.of(context)!.settings.arguments as AllSite;
    return Scaffold(
        appBar: AppBar(
          title: Text(siteInfo.name ?? "N/A"),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(siteInfo.domain ?? "N/A", style: TextStyle(color: Colors.white54),),
      ));
  }
}