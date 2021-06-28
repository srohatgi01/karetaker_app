import 'package:karetaker/data/models/bloodpressure.dart';
import 'package:karetaker/data/models/healthstats.dart';
import 'package:karetaker/data/models/heartrate.dart';
import 'package:karetaker/data/models/sugar.dart';
import 'package:karetaker/data/provider/health_stats_api.dart';

class HealthStatsRepo {
  final HealthStatsApi _healthStatsApi = HealthStatsApi();

  fetchLatestSugarStats({required emailAddress}) async {
    var sugarResponse =
        await _healthStatsApi.fetchLatestSugarRate(emailAddress: emailAddress);

    Sugar sugarReading = Sugar.fromRawJson(sugarResponse.body);

    return sugarReading;
  }

  fetchLatestHeartStats({required emailAddress}) async {
    var heartResponse =
        await _healthStatsApi.fetchLatestHeartRate(emailAddress: emailAddress);

    HeartRate heartReading = HeartRate.fromRawJson(heartResponse.body);

    return heartReading;
  }

  fetchLatestBloodPressureStats({required emailAddress}) async {
    var bloodResponse =
        await _healthStatsApi.fetchLatestBloodRate(emailAddress: emailAddress);

    BloodPressure bloodPressureReading =
        BloodPressure.fromRawJson(bloodResponse.body);

    return bloodPressureReading;
  }

  fetchStatsByUserId({required emailAddress}) async {
    var decodedSugarJson = await _healthStatsApi.fetchSugarReadingsById(
        emailAddress: emailAddress);
    var decodedBloodPressureJson = await _healthStatsApi
        .fetchBloodPressureReadingsById(emailAddress: emailAddress);
    var decodedHeartRateJson = await _healthStatsApi.fetchHeartRateReadingsById(
        emailAddress: emailAddress);

    List<Sugar> sugarReadings = [];
    List<HeartRate> heartRateReadings = [];
    List<BloodPressure> bloodPressureReadings = [];

    for (var reading in decodedSugarJson) {
      var sugar = Sugar.fromJson(reading);
      sugarReadings.add(sugar);
    }

    for (var reading in decodedBloodPressureJson) {
      var bp = BloodPressure.fromJson(reading);
      bloodPressureReadings.add(bp);
    }

    for (var reading in decodedHeartRateJson) {
      var heartRate = HeartRate.fromJson(reading);
      heartRateReadings.add(heartRate);
    }

    HealthStats healthStats =
        HealthStats(sugarReadings, heartRateReadings, bloodPressureReadings);
    print('sugar - ${healthStats.sugarReadings.length}');
    print('heart rate - ${healthStats.heartRateReadings.length}');
    print('bp - ${healthStats.bloodPressureReadings.length}');
    return healthStats;
  }
}
