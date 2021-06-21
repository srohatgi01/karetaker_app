import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:karetaker/constants/strings.dart';

class SearchApi {
  search({required keyword}) async {
    try {
      var response = await http.get(Uri.parse(SEARCH_DOCTORS + keyword));

      var decodedJson = json.decode(response.body);

      return decodedJson;
    } on Exception catch (e) {
      print('Exception - ' + e.toString());
    }
  }
}
