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

  postSugarRate({required json}) async {
    try {
      var response = await http.post(Uri.parse(CREATE_SUGAR_READING),
          body: json,
          headers: <String, String>{HEADER_DETAILS_KEY: HEADER_DETAILS_VALUE});

      response.statusCode == 200
          ? print('Sugar added successfully\n\n${response.body}')
          : print('Something wrong happened');
    } on Exception catch (e) {
      print('Sugar Reading creation error: $e');
    }
  }

  postBloodRate({required json}) async {
    try {
      var response = await http.post(Uri.parse(CREATE_BLOODPRESSURE_READING),
          body: json,
          headers: <String, String>{HEADER_DETAILS_KEY: HEADER_DETAILS_VALUE});

      response.statusCode == 200
          ? print('Blood Reading added Successfully\n\n\n${response.body}')
          : print('something wrong happened');
    } on Exception catch (e) {
      print('Creation blood rate error: $e');
    }
  }

  postHeartRate({required json}) async {
    try {
      var response = await http.post(Uri.parse(CREATE_HEARTRATE_READING),
          body: json,
          headers: <String, String>{HEADER_DETAILS_KEY: HEADER_DETAILS_VALUE});

      response.statusCode == 200
          ? print('Heart Rate Reading added Successfully\n\n\n${response.body}')
          : print('something wrong happened');
    } on Exception catch (e) {
      print('Creation blood rate error: $e');
    }
  }
}
