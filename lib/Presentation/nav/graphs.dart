import 'package:flutter/material.dart';
import 'package:karetaker/data/models/bloodpressure.dart';
import 'package:karetaker/data/models/healthstats.dart';
import 'package:karetaker/data/models/heartrate.dart';
import 'package:karetaker/data/models/sugar.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/health_stats_repo.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Health Stats Page'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            futureBuilder(user),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget futureBuilder(User user) {
    return FutureBuilder(
      future:
          HealthStatsRepo().fetchStatsByUserId(emailAddress: user.emailAddress),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          HealthStats healthStats = snapshot.data as HealthStats;
          return Column(
            children: [
              SfCartesianChart(
                margin: EdgeInsets.only(top: 50),
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                  text: 'Sugar Readings',
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<Sugar, String>>[
                  LineSeries<Sugar, String>(
                    dataSource: healthStats.sugarReadings,
                    xValueMapper: (Sugar reading, _) =>
                        '${reading.timestamp!.day}/${reading.timestamp!.month}',
                    yValueMapper: (Sugar reading, _) =>
                        int.parse(reading.value!),
                    name: 'Sugar Reading',
                    xAxisName: 'Time',
                    yAxisName: 'Readings',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
              SfCartesianChart(
                margin: EdgeInsets.only(top: 50),
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                  text: 'Blood Pressure Readings',
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<BloodPressure, String>>[
                  LineSeries<BloodPressure, String>(
                      dataSource: healthStats.bloodPressureReadings,
                      xValueMapper: (BloodPressure reading, _) =>
                          '${reading.timestamp!.day}/${reading.timestamp!.month}',
                      yValueMapper: (BloodPressure reading, _) =>
                          int.parse(reading.readingValue!),
                      name: 'BP Reading',
                      xAxisName: 'Time',
                      yAxisName: 'Readings',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ],
              ),
              SfCartesianChart(
                margin: EdgeInsets.only(top: 50),
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(
                  text: 'Heart Rate Readings',
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<HeartRate, String>>[
                  LineSeries<HeartRate, String>(
                      dataSource: healthStats.heartRateReadings,
                      xValueMapper: (HeartRate reading, _) =>
                          '${reading.timestamp!.day}/${reading.timestamp!.month}',
                      yValueMapper: (HeartRate reading, _) =>
                          int.parse(reading.readingValue!),
                      name: 'Heart Rate Reading',
                      xAxisName: 'Time',
                      yAxisName: 'Readings',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ],
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else
          return Text('nothign returned');
      },
    );
  }
}
