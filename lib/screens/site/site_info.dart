import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptime_monitor/screens/site/components/daily_checks_chart.dart';
import 'dart:convert';

import '../../config.dart';
import '../../models/AllSites.dart';

class SiteInfo extends StatefulWidget {
  final int siteId;

  const SiteInfo({super.key, required this.siteId});

  @override
  _SiteInfoState createState() => _SiteInfoState();
}

class _SiteInfoState extends State<SiteInfo> {
  late Future<AllSite> _siteData;

  @override
  void initState() {
    super.initState();
    _siteData = fetchSiteData(widget.siteId);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<AllSite> fetchSiteData(int siteId) async {
    final String? token = await _getToken();
    var url = Uri.parse('$apiUrl/api/sites/$siteId');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );

    int _convertTimeToMinutes(String dateTime) {
      final time = DateTime.parse(dateTime);
      return time.hour * 60 + time.minute;
    }


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final checks = (data['site']['root_endpoint']['checks'] as List)
          .map((check) {
        final dateTime = DateTime.parse(check['created_at']['date_time']);
        return MapEntry<int, double>(
            _convertTimeToMinutes(check['created_at']['date_time']),
            check['response_time'].toDouble());
      }).toList();
      return AllSite.fromJson(data['site'])
        ..responseTimes = Map.fromEntries(checks);
    } else {
      throw Exception('Failed to load site data');
    }
  }

  Future<void> deleteSite(int siteId) async {
    final String? token = await _getToken();
    var url = Uri.parse('$apiUrl/api/sites/$siteId');
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print('Site deleted successfully');
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<AllSite>(
          future: _siteData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (!snapshot.hasData) {
              return Text('N/A');
            } else {
              final siteInfo = snapshot.data!;
              return Text(siteInfo.name ?? 'Site Info');
            }
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white54),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  break;
                case 'delete':
                  deleteSite(widget.siteId);
                default:
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<AllSite>(
              future: _siteData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error loading site data: ${snapshot.error}");
                } else if (!snapshot.hasData) {
                  return Text("No data available.");
                } else {
                  final siteInfo = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${siteInfo.name ?? "N/A"}',
                        style: TextStyle(color: Colors.white54),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Domain: ${siteInfo.domain ?? "N/A"}',
                        style: TextStyle(color: Colors.white54),
                      ),
                      SizedBox(height: 32),

                      // DailyChecksChart()
                      siteInfo.responseTimes != null &&
                          siteInfo.responseTimes!.isNotEmpty
                          ? SizedBox(
                        height: 300, // Adjust height as needed
                        child: DailyChecksChart(
                            responseTimes: siteInfo.responseTimes!),
                      )
                          : Text("No checks data available."),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
