import 'package:karetaker/data/models/doctor_profile.dart';
import 'package:karetaker/data/models/search_doctor.dart';
import 'package:karetaker/data/models/slots.dart';
import 'package:karetaker/data/provider/search_api.dart';

class SearchRepo {
  search({required keyword}) async {
    var decodedJson = await SearchApi().searchDoctors(keyword: keyword);
    // print(decodedJson);
    List<SearchDoctor> doctors = [];
    for (var doc in decodedJson) {
      var doctor = SearchDoctor.fromJson(doc);

      doctors.add(doctor);
    }

    // print(doctors.toList());
    return doctors;
  }

  doctorProfile({required doctorId}) async {
    var decodedJson =
        await SearchApi().getDoctorProfileById(doctorId: doctorId);

    DoctorProfile doctorProfile = DoctorProfile.fromJson(decodedJson);

    return doctorProfile;
  }

  fetchAvailableSlots({required String date, required String doctorId}) async {
    var decodedJson =
        await SearchApi().findAvailableSlots(date: date, doctorId: doctorId);

    List<Slots> slots = [];
    for (var slot in decodedJson) {
      var newSlot = Slots.fromJson(slot);
      slots.add(newSlot);
    }

    return slots;
  }
}
