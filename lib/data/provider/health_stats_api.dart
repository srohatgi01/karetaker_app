import 'package:http/http.dart' as http;
import 'package:karetaker/constants/strings.dart';

class HealthStatsApi {
  fetchLatestSugarRate({required emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse(GET_LATEST_SUGAR_READING + emailAddress));

      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  fetchLatestBloodRate({required emailAddress}) async {
    try {
      var response = await http
          .get(Uri.parse(GET_LATEST_BLOODPRESSURE_READING + emailAddress));

      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  fetchLatestHeartRate({required emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse(GET_LATEST_HEART_READING + emailAddress));

      return response;
    } on Exception catch (e) {
      print(e);
    }
  }

  postSugarRate() {}
  postBloodRate() {}
  postHeartRate() {}
}
