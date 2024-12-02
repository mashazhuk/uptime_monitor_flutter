import 'package:flutter/material.dart';
import 'package:uptime_monitor/models/AllSites.dart';
import 'package:uptime_monitor/responsive.dart';
import 'package:flutter/cupertino.dart';

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
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                allSiteCard(context, demoAllSites[index]),
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
                      (index) => allSiteDataRow(context, demoAllSites[index]),
                ),
              ),
            ),
        ],
      ),
    );
  }

  DataRow allSiteDataRow(BuildContext context, AllSite siteInfo) {
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

  Widget allSiteCard(BuildContext context, AllSite siteInfo) {
    bool isUp = siteInfo.lastStatus?.contains("200") ?? false;
    return Card(
      margin: EdgeInsets.only(bottom: defaultPadding),
      color: secondaryColor,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed("/site-info", arguments: siteInfo),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: isUp ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      siteInfo.name ?? "N/A",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
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
              Text(
                "Uptime: ${siteInfo.uptime ?? "N/A"}",
                style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

