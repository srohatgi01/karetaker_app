import 'package:karetaker/data/models/doctor.dart';
import 'package:karetaker/data/provider/search_api.dart';

class SearchRepo {
  search({required keyword}) async {
    var decodedJson = await SearchApi().search(keyword: keyword);
    // print(decodedJson);
    List<Doctor> doctors = [];
    for (var doc in decodedJson) {
      var doctor = Doctor.fromJson(doc);

      doctors.add(doctor);
    }

    // print(doctors.toList());
    return doctors;
  }
}
