import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:karetaker/constants/strings.dart';

class SearchApi {
  searchDoctors({required keyword}) async {
    try {
      var response = await http.get(Uri.parse(SEARCH_DOCTORS + keyword));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Exception - ' + e.toString());
    }
  }

  getDoctorProfileById({required doctorId}) async {
    try {
      var response = await http.get(Uri.parse(GET_DOCTOR_BY_ID + doctorId));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Exception: $e');
    }
  }

  findAvailableSlots({required String date, required String doctorId}) async {
    try {
      var parsed = Uri.parse(GET_FREE_SLOTS + doctorId + '/' + date);
      print('parsed - ' + parsed.toString());
      var response = await http.get(parsed);

      var decodedJson = json.decode(response.body);
      print(decodedJson);
      return decodedJson;
    } on Exception catch (e) {
      print('Search Exception $e');
    }
  }
}
