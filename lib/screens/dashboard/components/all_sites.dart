import 'package:flutter/material.dart';
import 'package:uptime_monitor/models/AllSites.dart';
import 'package:uptime_monitor/responsive.dart';

import '../../../constants.dart';

class AllSites extends StatelessWidget {
  const AllSites({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All sites",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: defaultPadding),
          if (!Responsive.isDesktop(context))
            ListView.builder(
              shrinkWrap: true,
              itemCount: demoAllSites.length,
              itemBuilder: (context, index) => allSiteCard(demoAllSites[index]),
            )
          else
            SizedBox(
              width: double.infinity,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Domain")),
                  DataColumn(label: Text("Last check")),
                  DataColumn(label: Text("Last status")),
                  DataColumn(label: Text("Uptime")),
                  DataColumn(label: Text("")),
                ],
                rows: List.generate(
                  demoAllSites.length,
                      (index) => allSiteDataRow(demoAllSites[index]),
                ),
              ),
            ),
        ],
      ),
    );
  }

  DataRow allSiteDataRow(AllSite siteInfo) {
    return DataRow(
      cells: [
        DataCell(Text(siteInfo.name ?? "N/A")),
        DataCell(Text(siteInfo.domain ?? "N/A")),
        DataCell(Text(siteInfo.lastCheck ?? "N/A")),
        DataCell(Text(siteInfo.lastStatus ?? "N/A")),
        DataCell(Text(siteInfo.uptime ?? "N/A")),
        DataCell(
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget allSiteCard(AllSite siteInfo) {
    return Card(
      margin: EdgeInsets.only(bottom: defaultPadding),
      color: secondaryColor,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${siteInfo.name ?? "N/A"}",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Domain: ${siteInfo.domain ?? "N/A"}"),
            Text("Last check: ${siteInfo.lastCheck ?? "N/A"}"),
            Text("Last status: ${siteInfo.lastStatus ?? "N/A"}"),
            Text("Uptime: ${siteInfo.uptime ?? "N/A"}"),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

