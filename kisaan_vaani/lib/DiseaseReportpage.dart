import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kisaan_vaani/language_change.dart';
import 'package:provider/provider.dart';

class DiseaseReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.report),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0), // Add some space at the top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.report,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        DropdownButton<String>(
                          icon: Icon(Icons.download),
                          underline: Container(),
                          items: <String>['PDF', 'Word', 'Excel', 'Jpg', 'Png']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // Implement download functionality here
                            // For example:
                            // downloadReport(newValue);
                          },
                          hint: Text("Download"),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            // Implement view functionality here
                            // For example:
                            // viewReport();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
              height: 16.0), // Add some space between the card and the content
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.result,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
