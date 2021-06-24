import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/doctor_profile.dart';
import 'package:karetaker/data/models/hospitals.dart';
import 'package:karetaker/data/repositories/search_repo.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorPage extends StatefulWidget {
  final doctor;

  const DoctorPage({Key? key, this.doctor}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  CalendarController calendarController = CalendarController();
  String apiDate = '';
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.center,
            child: Text(
                'Dr. ${widget.doctor.firstName} ${widget.doctor.lastName}\'s Profile')),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: SearchRepo().doctorProfile(doctorId: widget.doctor.doctorId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var doc = snapshot.data as DoctorProfile;
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ' +
                          doc.firstName.toString() +
                          ' ' +
                          doc.lastName.toString(),
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 12),
                      child: Text(
                        doc.specialities!.specialityName.toString(),
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Text('Practicing for '),
                        Text(
                          doc.practicingYears.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(' years')
                      ],
                    ),
                    hospitalCard(doc.hospitalsHasDoctors![0].hospitals),
                    calendar(),
                  ],
                ),
              );
            } else {
              return Text('Data will load soon ig');
            }
          },
        ),
      ),
    );
  }

  hospitalCard(Hospitals? hospital) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 8, left: 30, right: 16),
            child: Text(
              hospital!.hospitalName.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 16, top: 8, bottom: 35),
            child: Text(
              hospital.hospitalAddress.toString(),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  calendar() {
    return Container(
      height: 150,
      child: SfCalendar(
        minDate: DateTime.now(),
        maxDate: DateTime.now().add(Duration(days: 10)),
        firstDayOfWeek: 1,

        view: CalendarView.month,
        viewHeaderHeight: 40,
        headerHeight: 50,
        initialSelectedDate: DateTime.now(),
        headerStyle: CalendarHeaderStyle(
          backgroundColor: Color(PRIMARY_COLOR),
          textAlign: TextAlign.center,
          textStyle: TextStyle(color: Colors.white, fontSize: 22),
        ),
        cellEndPadding: 0,
        showNavigationArrow: true,
        // cellBorderColor: Colors.transparent,
        controller: calendarController,
        monthCellBuilder: (context, MonthCellDetails details) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Text(details.date.day.toString()),
          );
        },
        onSelectionChanged: (date) {
          // setState(() {
          //   // apiDate = date.date!.year.toString();
          // });
        },
        monthViewSettings: MonthViewSettings(
          showTrailingAndLeadingDates: false,
          navigationDirection: MonthNavigationDirection.horizontal,
          numberOfWeeksInView: 1,
          dayFormat: 'EEE',
        ),
      ),
    );
  }
}
