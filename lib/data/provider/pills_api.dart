import 'dart:convert';
import 'package:karetaker/constants/strings.dart';
import 'package:http/http.dart' as http;

class PillsApi {
  fetchPills({required String emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse(FETCH_USER_PILLS + '/' + emailAddress));

      // raw json body getting decoded
      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print(e);
    }
  }

  // this function takes the raw json and just pass it to the body of the request
  createNewPill({required json}) async {
    try {
      var response = await http.post(
        Uri.parse(CREATE_USER_PILL),
        body: json,
        headers: <String, String>{HEADER_DETAILS_KEY: HEADER_DETAILS_VALUE},
      );

      print('Raw Response - ' + response.toString());
      print('Pill added in Database Successfully');
    } on Exception catch (e) {
      print(e);
    }
  }
}
