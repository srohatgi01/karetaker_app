import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karetaker/Presentation/nav/appointments_history.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:karetaker/Presentation/nav/features/add_readings.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/bloodpressure.dart';
import 'package:karetaker/data/models/heartrate.dart';
import 'package:karetaker/data/models/pills.dart';
import 'package:karetaker/data/models/sugar.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/health_stats_repo.dart';
import 'package:karetaker/data/repositories/pills_repo.dart';
import 'package:karetaker/presentation/nav/reports.dart';
import 'package:provider/provider.dart';
import 'features/add_pill.dart';
import 'features/pills_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    var pills = PillsRepository().fetchPills(
        emailAddress: Provider.of<User>(context).emailAddress.toString());
    var sugarReading = HealthStatsRepo()
        .fetchLatestSugarStats(emailAddress: user.emailAddress);
    var heartReading = HealthStatsRepo()
        .fetchLatestHeartStats(emailAddress: user.emailAddress);
    var bloodReading = HealthStatsRepo()
        .fetchLatestBloodPressureStats(emailAddress: user.emailAddress);

    return Scaffold(
      appBar: _appBar(context, user: user),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            _greetingHead(firstName: user.firstName.toString()),
            _greetingSubHead(),
            _subHeading(title: 'Pills'),
            _pillsCarousel(future: pills, userDetails: user),
            healthStatsHeadingRow(user: user),
            _sugarReading(future: sugarReading),
            _heartReading(future: heartReading),
            _bloodPressureReading(future: bloodReading)
          ],
        ),
      ),
    );
  }

  Row healthStatsHeadingRow({required user}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _subHeading(title: 'Latest Health Stats'),
        IconButton(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(right: 40),
            icon: Icon(
              Icons.add,
              size: 40,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Which reading would you like to add?'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Provider<User>(
                                          create: (context) => user,
                                          child:
                                              AddReading(readingType: 'sugar'),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Sugar Reading')),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Provider<User>(
                                          create: (context) => user,
                                          child: AddReading(readingType: 'bp'),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Blood Pressure Reading')),
                            ),
                            Container(
                              width: 250,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Provider<User>(
                                          create: (context) => user,
                                          child: AddReading(
                                              readingType: 'heartrate'),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Heart Rate Reading')),
                            ),
                          ],
                        ),
                      ));
            })
      ],
    );
  }

  AppBar _appBar(BuildContext context, {required User user}) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          tooltip: 'Show Reports',
          icon: Icon(
            Icons.padding_outlined,
            size: 32,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Provider<User>(
                    create: (context) => user,
                    child: ReportsPage(),
                  ),
                ));
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            tooltip: 'Show Booked Appointments',
            icon: Icon(
              FontAwesomeIcons.notesMedical,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Provider<User>(
                    create: (context) => user,
                    child: AppointmentHistoryPage(),
                  ),
                ),
              );
            },
          ),
        )
      ],
      title: Center(child: Text(APP_NAME)),
    );
  }

  Widget _bloodPressureReading({required future}) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var reading = snapshot.data as BloodPressure;
            return _healthStatCard(
              reading: reading.readingValue,
              unit: 'mmHg',
              icon: FontAwesomeIcons.prescription,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error getting data');
          } else {
            return Text('Nothing to show here');
          }
        });
  }

  Widget _heartReading({required future}) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var reading = snapshot.data as HeartRate;
            return _healthStatCard(
              reading: reading.readingValue,
              unit: 'bpm',
              icon: FontAwesomeIcons.heartbeat,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error getting data');
          } else {
            return Text('Nothing to show here');
          }
        });
  }

  Widget _sugarReading({required future}) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var reading = snapshot.data as Sugar;
            return _healthStatCard(
              reading: reading.value,
              unit: 'mg/dL',
              icon: FontAwesomeIcons.solidWindowRestore,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error getting data');
          } else {
            return Text('Nothing to show here');
          }
        });
  }

  Widget _greetingHead({required firstName}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Welcome back ' + firstName + ',',
        style: TextStyle(fontSize: 26),
      ),
    );
  }

  Widget _greetingSubHead() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text('How are you feeling today?',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade700)),
    );
  }

  Widget _subHeading({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, bottom: 8),
      child: Text('$title',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
    );
  }

  Widget pillsCard({medName, time}) {
    var hours = int.parse(time.split(':')[0]);
    var minutes = time.split(':')[1];
    var timeFrame;
    var convertedHours;
    if (hours > 12) {
      convertedHours = hours - 12;
      timeFrame = 'PM';
    } else {
      convertedHours = hours;
      timeFrame = 'AM';
    }

    // print('time frame - ' + timeFrame.toString());
    return Container(
      width: 300,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(16),
            child: Text(
              '$medName',
              style: TextStyle(fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 7, right: 3),
                  child: Icon(
                    Icons.alarm,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  '$convertedHours:$minutes $timeFrame',
                  style: TextStyle(fontSize: 35),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget addPillCard({required userDetails}) {
    return Hero(
      tag: 'addPill',
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 16, bottom: 3, top: 3),
        width: 110,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade700,
              blurRadius: 8,
            ),
          ],
          color: Colors.white,
        ),
        child: IconButton(
          icon: Icon(
            Icons.add,
            size: 60,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Provider<User>(
                  create: (context) => userDetails,
                  child: AddPill(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _pillsCarousel({required future, required userDetails}) {
    return SizedBox(
      height: 160.0,
      child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Pills> pills = snapshot.data as List<Pills>;
              return ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: pills.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Card(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PillDetails(
                                          pill: pills[index],
                                        )));
                          },
                          child: pillsCard(
                            medName: pills[index].pillName,
                            time: pills[index].pillTime,
                          ),
                        ),
                      ),
                    ),
                  ),
                  addPillCard(userDetails: userDetails),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return Text('Nothing Returned');
            }
          }),
    );
  }

  Widget _healthStatCard({required reading, required unit, required icon}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 8,
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 35,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 30),
            child: Text(
              '$reading $unit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
