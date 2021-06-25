import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/doctor_profile.dart';
import 'package:karetaker/data/models/hospitals.dart';
import 'package:karetaker/data/models/appointment.dart' as App;
import 'package:karetaker/data/models/slots.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/provider/search_api.dart';
import 'package:karetaker/data/repositories/appointment_repo.dart';
import 'package:karetaker/data/repositories/search_repo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorPage extends StatefulWidget {
  final doctor;

  DoctorPage({Key? key, required this.doctor}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  final CalendarController calendarController = CalendarController();
  final TextEditingController remarksController = TextEditingController();

  var selectedSlotId;
  var remarks;
  var fulldate = '';
  var selectedSlot;
  var hospitalId;

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
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: SearchRepo()
                    .doctorProfile(doctorId: widget.doctor.doctorId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    var doc = snapshot.data as DoctorProfile;
                    hospitalId = doc.hospitalsHasDoctors![0].hospitalId;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. ' +
                                doc.firstName.toString() +
                                ' ' +
                                doc.lastName.toString(),
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
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
                        ]);
                  } else {
                    return Text('Data will load soon ig');
                  }
                },
              ),
              calendar(widget.doctor.doctorId),
              StreamBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    var slots = snapshot.data as List<Slots>;
                    return slots.isNotEmpty
                        ? Container(
                            margin: EdgeInsets.only(top: 30),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 60, crossAxisCount: 3),
                              shrinkWrap: true,
                              itemCount: slots.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedSlot = index;
                                    selectedSlotId = slots[index].slotId;
                                  });
                                  print(selectedSlotId);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: selectedSlot == index
                                          ? Color(PRIMARY_COLOR).withOpacity(.4)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 2,
                                            spreadRadius: 1)
                                      ]),
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    slots[index].startTime.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Text('All slots are booked for the date.');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        'Please Select a date to view time slots',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                },
                stream: Stream.fromFuture(SearchRepo().fetchAvailableSlots(
                    date: fulldate, doctorId: widget.doctor.doctorId)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Remarks',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: remarksController,
                  maxLines: null,
                  autofocus: false,
                  textAlign: TextAlign.left,
                  decoration: new InputDecoration(
                    labelText: "Enter Remarks here",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  style: new TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                  ),
                  onChanged: (value) => {},
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var userEmail = prefs.getString('emailAddress');
                  print(userEmail);
                  AppointmentRepo().createNewAppointment(
                    appointmentDate: fulldate,
                    userId: userEmail,
                    doctorId: widget.doctor.doctorId,
                    hospitalId: hospitalId,
                    slotId: selectedSlotId,
                    remarks: remarksController.value.text,
                  );

                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Appointment Booked successfully'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  int count = 0;
                                  Navigator.of(context)
                                      .popUntil((_) => count++ >= 2);
                                },
                                child: Text('Okay'),
                              ),
                            ],
                          ));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  child: Text('Book Appointment',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
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

  calendar(doctorId) {
    return Container(
      height: 150,
      child: SfCalendar(
        minDate: DateTime.now(),
        maxDate: DateTime.now().add(Duration(days: 10)),
        firstDayOfWeek: 1,
        view: CalendarView.month,
        viewHeaderHeight: 40,
        headerHeight: 50,
        initialDisplayDate: DateTime.now(),
        // initialSelectedDate: DateTime.now(),
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
          var day = date.date!.day;
          var month = date.date!.month;
          var year = date.date!.year;
          this.setState(() {
            selectedSlot = null;
            fulldate = month < 10 ? '$year-0$month-$day' : '$year-$month-$day';
          });
          print(fulldate);
          print(doctorId);
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
