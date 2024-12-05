import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptime_monitor/constants.dart';

import '../../models/AllSites.dart';

class AddSite extends StatefulWidget {
  const AddSite({super.key});
  @override
  State<AddSite> createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  @override
  Widget build(BuildContext context) {
    // final AllSite siteInfo = ModalRoute.of(context)!.settings.arguments as AllSite;
    return Scaffold(
        appBar: AppBar(
          title: Text("N/A"),
        ),
        body: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              fillColor: secondaryColor,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)
              ),
              suffixIcon: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                child: SvgPicture.asset("assets/icons/Search.svg"),
                ),
              ),
            ),
        )
    );
  }
}