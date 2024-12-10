import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return AllSite.fromJson(data['site']);
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
                    ],
                  );
                }
              },
            ),
          FutureBuilder<List<dynamic>>(
          future: fetchChecks(siteId), // Загрузка данных
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
          } else {
          final checks = snapshot.data!;
          return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
          children: [
          Text(
          'Response Time Chart',
          style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          SizedBox(
          height: 300,
          child: ResponseTimeChart(checks: checks),
          ),
          ],
          ),
          );
          ],

        ),
      ),

    );
  }
}
