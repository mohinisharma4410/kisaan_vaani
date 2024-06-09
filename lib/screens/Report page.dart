import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  final String reportData;

  ReportPage({required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Page'),
      ),
      body: Center(
        child: Text(
          reportData,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
