import 'package:flutter/material.dart';



class DiseaseReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Report'),
      ),
      body: Center(
        child: Text(
          'Disease detection result will be shown here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
