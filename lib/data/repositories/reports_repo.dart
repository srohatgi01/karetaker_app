import 'package:karetaker/data/models/reports.dart';
import 'package:karetaker/data/provider/reports_api.dart';

class ReportsRepo {
  getUserReports({required String emailAddress}) async {
    var decodedJson =
        await ReportsApi().getUserReports(emailAddress: emailAddress);

    List<Reports> reports = [];

    for (var report in decodedJson) {
      reports.add(report);
    }

    return reports;
  }
}
