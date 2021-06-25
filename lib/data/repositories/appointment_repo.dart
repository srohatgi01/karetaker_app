import 'package:karetaker/data/models/appointment.dart';
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
      // appointmentDate: appointmentDate,
      userId: userId,
      doctorId: doctorId,
      hospitalId: hospitalId,
      slotId: slotId,
      remarks: remarks,
    ).toRawJson();
    print(json);
    await AppointmentApi().createNewAppointment(json: json);
  }
}
