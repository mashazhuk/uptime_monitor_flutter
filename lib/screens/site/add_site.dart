import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptime_monitor/config.dart';

import 'components/add_site_form.dart';

class AddSite extends StatefulWidget {
  const AddSite({super.key});

  @override
  State<AddSite> createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  List<Map<String, dynamic>> monitorTypes = [];
  List<Map<String, dynamic>> frequencies = [];
  Map<String, dynamic>? site;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> fetchInitialData() async {
    try {
      final String? token = await _getToken();
      final response = await http.get(
        Uri.parse('$apiUrl/api/sites/create'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          monitorTypes = List<Map<String, dynamic>>.from(data['monitor_types']);
          frequencies = List<Map<String, dynamic>>.from(data['frequencies']);
          site = data['site'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add monitor"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: AddSiteForm(
          monitorTypes: monitorTypes,
          frequencies: frequencies,
          site: site,
        ),
      ),
    );
  }
}
