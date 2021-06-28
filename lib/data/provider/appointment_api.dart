import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:karetaker/constants/strings.dart';

class AppointmentApi {
  createNewAppointment({required json}) async {
    try {
      var response = await http.post(
        Uri.parse(CREATE_NEW_APPOINTMENT),
        body: json,
        headers: <String, String>{HEADER_DETAILS_KEY: HEADER_DETAILS_VALUE},
      );

      response.statusCode == 200
          ? print('New Appointment Booked')
          : print('Appointment didn\'t book');
    } on Exception catch (e) {
      print(e);
    }
  }

  fetchAppointmentsByUserId({required emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse(GET_APPOINTMENTS_OF_USER + emailAddress));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Fetch Appointments from User Id Error - $e');
    }
  }
}
