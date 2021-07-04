import 'package:flutter/material.dart';
import 'package:karetaker/Presentation/widgets/appointment_history_card.dart';
import 'package:karetaker/data/models/appointment_history.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/appointment_repo.dart';
import 'package:provider/provider.dart';

class AppointmentHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments History'),
      ),
      body: StreamBuilder(
        stream: Stream.fromFuture(
          AppointmentRepo()
              .fetchUserAppointments(emailAddress: user.emailAddress),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            var list = snapshot.data as List<AppointmentHistory>;
            return list.isEmpty
                ? noAppointmentsFound()
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return AppointmentHistoryCard(
                        appointmentId: list[index].appointmentId,
                        doctorName:
                            '${list[index].doctors!.firstName}  ${list[index].doctors!.lastName}',
                        appointmentStatus: list[index].status,
                        hospitalName: list[index].hospitals!.hospitalName,
                        hospitalAddress: list[index].hospitals!.hospitalAddress,
                        appointmentTime: list[index].slots!.startTime,
                        appointmentDate:
                            '${list[index].appointmentDate!.day}-${list[index].appointmentDate!.month}-${list[index].appointmentDate!.year}',
                      );
                    },
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Somthing wrong happened'),
            );
          }
        },
      ),
    );
  }

  Widget noAppointmentsFound() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset(
              'assets/noapp.png',
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                Text(
                  'No appointments? You must be new!',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Go back and tap on heart to book your first appointment',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
