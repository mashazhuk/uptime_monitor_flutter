import 'package:flutter/material.dart';
import 'package:uptime_monitor/models/AllSites.dart';
import 'package:uptime_monitor/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class AllSites extends StatefulWidget {
  const AllSites({
    super.key,
  });

  State<AllSites> createState() => _AllSitesState();
}

class _AllSitesState extends State<AllSites> {
  late Future<List<AllSite>> siteFuture;

  @override
  void initState() {
    super.initState();
    siteFuture = getSites();
  }

  static Future<List<AllSite>> getSites() async {
    var url = Uri.parse("https://uptime-monitor.test/api/sites/");
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final body = json.decode(response.body);

    if (body is Map<String, dynamic> && body.containsKey('sites')) {
      final List<dynamic> sites = body['sites'];
      return sites.map((e) => AllSite.fromJson(e)).toList();
    } else {
      throw Exception('Unexpected JSON structure: missing "sites" key');
    }
  }

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
          FutureBuilder<List<AllSite>>(
            future: siteFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No sites available.'));
              }

              final sites = snapshot.data!;
              if (!Responsive.isDesktop(context)) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: sites.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => allSiteCard(context, sites[index]),
                );
              } else {
                return SizedBox(
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
                    rows: sites
                        .map((site) => allSiteDataRow(context, site))
                        .toList(),
                  ),
                );
              }
            },
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
        DataCell(Text(siteInfo.lastStatusCode?.toString() ?? "N/A")),
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
      bool isUp = siteInfo.lastStatusCode == 200;
      bool hasLatestCheck = siteInfo.lastCheck != null;
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
                    color: hasLatestCheck
                        ? (isUp ? Colors.green : Colors.red)
                        : Colors.grey,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "${siteInfo.name ?? "N/A"}",
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


