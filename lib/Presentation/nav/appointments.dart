import 'package:flutter/material.dart';
import 'package:karetaker/Presentation/widgets/appointment_history.dart';
import 'package:karetaker/data/models/appointment_history.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/appointment_repo.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Page'),
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

  // Widget appointmentHistoryCard({
  //   doctorName,
  //   appointmentDate,
  //   appointmentTime,
  //   appointmentStatus,
  //   hospitalName,
  //   hospitalAddress,
  // }) {
  //   return Container(
  //     height: 150,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(8),
  //       boxShadow: [
  //         BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)
  //       ],
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         Container(
  //           width: 5,
  //           height: double.infinity,
  //           decoration: BoxDecoration(
  //             color: Color(PRIMARY_COLOR),
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(15),
  //               bottomLeft: Radius.circular(15),
  //             ),
  //           ),
  //         ),
  //         Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               mainAxisSize: MainAxisSize.max,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(top: 20.0, left: 16),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         'Dr. ' + doctorName,
  //                         style: TextStyle(
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 15.0),
  //                         child: Row(
  //                           children: [
  //                             Text(
  //                               'Date: ',
  //                               style: TextStyle(
  //                                   fontSize: 18, fontWeight: FontWeight.w500),
  //                             ),
  //                             Text(
  //                               appointmentDate,
  //                               style: TextStyle(
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 15.0),
  //                         child: Row(
  //                           children: [
  //                             Text(
  //                               'Time: ',
  //                               style: TextStyle(
  //                                   fontSize: 18, fontWeight: FontWeight.w500),
  //                             ),
  //                             Text(
  //                               appointmentTime,
  //                               style: TextStyle(
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(right: 20),
  //                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
  //                   decoration: BoxDecoration(
  //                     color: Color(PRIMARY_COLOR),
  //                     borderRadius: BorderRadius.circular(5),
  //                   ),
  //                   child: Text(
  //                     'COMPLETED',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Text('someja;dfj'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
