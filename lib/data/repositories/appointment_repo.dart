import 'package:karetaker/data/models/appointment.dart';
import 'package:karetaker/data/models/appointment_history.dart';
import 'package:karetaker/data/provider/appointment_api.dart';

class AppointmentRepo {
  createNewAppointment({
    required appointmentDate,
    required userId,
    required doctorId,
    required hospitalId,
    required slotId,
    required remarks,
  }) async {
    var json = Appointment(
      appointmentDate: appointmentDate + 'T00:00:00.000Z',
      userId: userId,
      doctorId: doctorId,
      hospitalId: hospitalId,
      slotId: slotId,
      remarks: remarks,
    ).toRawJson();
    print(json);
    await AppointmentApi().createNewAppointment(json: json);
  }

  fetchUserAppointments({required emailAddress}) async {
    var decodedJson = await AppointmentApi()
        .fetchAppointmentsByUserId(emailAddress: emailAddress);
    List<AppointmentHistory> appointmentList = [];

    for (var appointment in decodedJson) {
      var app = AppointmentHistory.fromJson(appointment);
      appointmentList.add(app);
    }

    return appointmentList;
  }
}
