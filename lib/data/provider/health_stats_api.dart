import 'dart:convert';

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

  fetchSugarReadingsById({required emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse(GET_SUGAR_READINGS_OF_USER + emailAddress));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Fetch Sugar Readings By Id Error - ' + e.toString());
    }
  }

  fetchBloodPressureReadingsById({required emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse(GET_BP_READINGS_OF_USER + emailAddress));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Fetch BP Readings By Id Error - ' + e.toString());
    }
  }

  fetchHeartRateReadingsById({required emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse(GET_HEART_READINGS_OF_USER + emailAddress));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Fetch Heart Rate Readings By Id Error - ' + e.toString());
    }
  }

  postSugarRate() {}
  postBloodRate() {}
  postHeartRate() {}
}
