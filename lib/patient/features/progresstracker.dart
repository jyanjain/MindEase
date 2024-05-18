import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressData {
  final String date;
  final String description;

  ProgressData(this.date, this.description);
}

class ProgressTrackingPage extends StatefulWidget {
  @override
  _ProgressTrackingPageState createState() => _ProgressTrackingPageState();
}

class _ProgressTrackingPageState extends State<ProgressTrackingPage> {
  List<ProgressData> progressList = [
    ProgressData("2023-10-01", "Completed VR session 1."),
    ProgressData("2023-10-05", "Attended therapy appointment."),
    ProgressData("2023-10-10", "VR session 2 - Overcame fear of heights."),
    // Add more progress data here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7EBE1),
      appBar: AppBar(
        title: Text('Progress Tracking'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 200, // Adjust the height as needed
            child: AspectRatio(
              aspectRatio: 1.7,
              child: LineChart(
                LineChartData(
                  // ... Chart data configuration
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: progressList.length.toDouble() - 1,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: progressList.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.key * 30.0);
                      }).toList(),
                      isCurved: true,
                      //  colors: [Colors.blue],
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: progressList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(progressList[index].date),
                  subtitle: Text(progressList[index].description),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
