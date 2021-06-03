import 'package:http/http.dart' as http;
import 'package:karetaker/constants/strings.dart';

class UserApi {
  fetchUser({required String emailAddress}) async {
    try {
      var response =
          await http.get(Uri.parse('$BASE_URL/users/getUser/$emailAddress'));
      if (response.statusCode == 200) {
        print('response - User Found in Database');
      } else if (response.statusCode == 404) {
        return response.statusCode;
      }
    } on Exception catch (e) {
      print('error - ' + e.toString());
    }
  }

  postUser({required json}) async {
    try {
      var response = await http.post(
        Uri.parse('$BASE_URL/users'),
        body: json,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('\n\nUser created Successfully: ' + response.body + '\n\n');
      print('\n\nResponse Code : ' + response.statusCode.toString() + '\n\n');
    } on Exception catch (e) {
      print('error - ' + e.toString());
    }
  }
}
