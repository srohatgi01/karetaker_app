import 'package:karetaker/data/models/pills.dart';
import 'package:karetaker/data/provider/pills_api.dart';

class PillsRepository {
  fetchPills({required emailAddress}) async {
    // getting the decoded json body
    var response = await PillsApi().fetchPills(emailAddress: emailAddress);

    List<Pills> pills = [];

    //We have a Pills model which will only take one pill from the decoded json. The following for in loop will take the decoded json and create a pills object and add it to the pills list.
    for (var obj in response) {
      pills.add(Pills.fromJson(obj));
    }

    return pills;
  }

  createNewPill({required Pills pill}) async {
    // converting pills model to raw json
    var json = pill.toRawJson();

    print('raw json - ' + json);

    // passing the raw json to PillsApi so create new pill;
    await PillsApi().createNewPill(json: json);
  }
}
