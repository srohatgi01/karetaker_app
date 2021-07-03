import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/repositories/appointment_repo.dart';

class AppointmentHistoryCard extends StatelessWidget {
  const AppointmentHistoryCard(
      {Key? key,
      this.doctorName,
      this.appointmentDate,
      this.appointmentTime,
      this.appointmentStatus,
      this.hospitalName,
      this.hospitalAddress,
      this.appointmentId})
      : super(key: key);

  final doctorName;
  final appointmentDate;
  final appointmentTime;
  final appointmentStatus;
  final hospitalName;
  final hospitalAddress;
  final appointmentId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        color: Color(PRIMARY_COLOR),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10))),
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Dr. $doctorName",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Date: ",
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                          Text('$appointmentDate',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      returnAppointmentStatus(appointmentStatus)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Time: ",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      Text('$appointmentTime',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("$hospitalName",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$hospitalAddress", style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 10,
                  ),
                  returnUpdateButton(appointmentStatus, context, appointmentId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  returnUpdateButton(appointmentStatus, context, appointmentId) {
    if (appointmentStatus == 'BOOKED') {
      return cancelStatusButton(context, appointmentId);
    } else {
      return SizedBox();
    }
  }

  Widget cancelStatusButton(BuildContext context, appointmentId) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(PRIMARY_COLOR),
      ),
      child: TextButton(
        child: Text(
          'Cancel Appointment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        onPressed: () => {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to cancel the appointment?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    AppointmentRepo()
                        .cancelAppointment(appointmentId: appointmentId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Appointment Cancelled Successfully.'),
                      ),
                    );
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                ),
              ],
            ),
          )
        },
      ),
    );
  }

  Widget returnAppointmentStatus(appointmentStatus) {
    if (appointmentStatus == 'COMPLETED') {
      return completed();
    } else if (appointmentStatus == 'BOOKED') {
      return booked();
    } else if (appointmentStatus == 'CANCELED_BY_USER') {
      return cancelledByUser();
    } else if (appointmentStatus == 'CANCELED_BY_DOCTOR') {
      return cancelledByDoctor();
    } else {
      return Text('something went wrong');
    }
  }

  Container completed() {
    return Container(
      width: 122,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Color(PRIMARY_COLOR),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        'COMPLETED',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Container booked() {
    return Container(
      alignment: Alignment.center,
      width: 122,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Color(BOOKED_BUTTON_COLOR),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        'BOOKED',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Container cancelledByDoctor() {
    return Container(
      alignment: Alignment.center,
      width: 122,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Color(CANCELLED_BUTTON_COLOR),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            'CANCELLED',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'BY DOCTOR',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Container cancelledByUser() {
    return Container(
      alignment: Alignment.center,
      width: 122,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Color(CANCELLED_BUTTON_COLOR),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            'CANCELLED',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'BY USER',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
