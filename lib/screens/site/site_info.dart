import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../models/AllSites.dart';

class SiteInfo extends StatelessWidget {
  const SiteInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final AllSite siteInfo = ModalRoute
        .of(context)!
        .settings
        .arguments as AllSite;
    return Scaffold(
        appBar: AppBar(
          title: Text(siteInfo.name ?? "N/A"),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.white54),
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    break;
                  case 'delete':
                    deleteSite(siteInfo.id);
                  default:
                }
              },
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            siteInfo.domain ?? "N/A", style: TextStyle(color: Colors.white54),),
        ));
  }
}

Future<void> deleteSite(int? siteId) async {
  var url = Uri.parse('$apiUrl/$siteId');
  final response = await http.delete(
    url, headers: {"Content-Type": "application/json"},);
    if (response.statusCode == 200) {
      print('Site deleted successfully');
    } else {
      print('Error');
    }
  }