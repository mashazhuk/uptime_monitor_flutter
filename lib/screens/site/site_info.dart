import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../config.dart';
import '../../models/AllSites.dart';
import 'components/daily_checks_chart.dart';

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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final checks = (data['site']['root_endpoint']['checks'] as List)
          .map((check) {
        final dateTime = DateTime.parse(check['created_at']['date_time']);
        return MapEntry<DateTime, double>(
          dateTime,
          check['response_time'].toDouble(),
        );
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
      Navigator.of(context).pop();
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
        child: FutureBuilder<AllSite>(
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
                      siteInfo.domain ?? "Site domain unavailable",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 150,
                      child: siteInfo.responseTimes != null &&
                          siteInfo.responseTimes!.isNotEmpty
                          ? DailyChecksChart(
                              responseTimes: filterCurrentDayData(siteInfo.responseTimes!),
                            )
                          : Center(
                              child: Text(
                                "No checks data available.",
                                style: const TextStyle(color: Colors.white),
                              ),
                          ),
                    ),
                  ],
              );
            }
          },
        ),
      ),
    );
  }
}
Map<int, double> filterCurrentDayData(Map<DateTime, double> originalData) {
  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);
  final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

  return Map.fromEntries(
    originalData.entries
      .where((entry) => entry.key.isAfter(todayStart) && entry.key.isBefore(todayEnd))
      .map((entry) => MapEntry(
        entry.key.hour * 60 + entry.key.minute,
        entry.value,
      ))
  );
}

