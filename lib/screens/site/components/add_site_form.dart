import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config.dart';
import '../../../constants.dart';

class AddSiteForm extends StatefulWidget {
  final List<Map<String, dynamic>> monitorTypes;
  final List<Map<String, dynamic>> frequencies;
  final Map<String, dynamic>? site;

  const AddSiteForm({
    super.key,
    required this.monitorTypes,
    required this.frequencies,
    this.site,
  });

  @override
  State<AddSiteForm> createState() => _AddSiteFormState();
}

class _AddSiteFormState extends State<AddSiteForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  String? selectedMonitorType;
  int? selectedFrequency;

  @override
  void initState() {
    super.initState();

    if (widget.site != null) {
      final siteData = widget.site!;
      setState(() {
        selectedMonitorType = siteData['monitor_type'];
        nameController.text = siteData['name'] ?? '';
        urlController.text = siteData['domain'] ?? '';
        selectedFrequency = siteData['root_endpoint']?['frequency_value'];
      });
    } else {
      selectedMonitorType = widget.monitorTypes.first['value'];
      selectedFrequency = widget.frequencies.first['frequency'];
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> submitForm() async {
    try {
      final String? token = await _getToken();
      final response = await http.post(
        Uri.parse('$apiUrl/api/sites'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'monitor_type': selectedMonitorType,
          'name': nameController.text,
          'domain': urlController.text,
          'frequency': selectedFrequency,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Site added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add site: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: selectedMonitorType,
          decoration: InputDecoration(
            labelText: 'Connection Type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: widget.monitorTypes
              .map((type) => DropdownMenuItem<String>(
            value: type['value'],
            child: Text(type['label']),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedMonitorType = value;
            });
          },
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: urlController,
          decoration: InputDecoration(
            labelText: 'URL',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        DropdownButtonFormField<int>(
          value: selectedFrequency,
          decoration: InputDecoration(
            labelText: 'Frequency',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: widget.frequencies
              .map((freq) => DropdownMenuItem<int>(
            value: freq['frequency'],
            child: Text(freq['label']),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedFrequency = value;
            });
          },
        ),
        const SizedBox(height: 16.0),
        // ElevatedButton(
        //   onPressed: submitForm,
        //   child: const Text("Submit"),
        // ),
        ElevatedButton.icon(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding,
            ),
          ),
          onPressed: submitForm,
          label: Text(
            "Create a monitor",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
