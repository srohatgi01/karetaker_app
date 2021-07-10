import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:karetaker/constants/strings.dart';

class ReportsApi {
  getUserReports({required String emailAddress}) async {
    try {
      var response = await http.get(Uri.parse(GET_USER_REPORTS + emailAddress));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Get user reports $e');
    }
  }
}
