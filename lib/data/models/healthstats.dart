import 'package:karetaker/data/models/bloodpressure.dart';
import 'package:karetaker/data/models/heartrate.dart';
import 'package:karetaker/data/models/sugar.dart';

class HealthStats {
  final List<Sugar> sugarReadings;
  final List<HeartRate> heartRateReadings;
  final List<BloodPressure> bloodPressureReadings;

  HealthStats(
      this.sugarReadings, this.heartRateReadings, this.bloodPressureReadings);
}
