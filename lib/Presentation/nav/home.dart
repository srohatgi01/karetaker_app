import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/pills.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/pills_repo.dart';
import 'package:karetaker/presentation/nav/graphs.dart';
import 'package:karetaker/presentation/nav/reports.dart';
import 'package:provider/provider.dart';

import 'features/add_pill.dart';

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

    print(pills);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            tooltip: 'Show Reports',
            icon: Icon(
              Icons.padding_outlined,
              size: 32,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReportsPage()));
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              tooltip: 'Show graphs',
              icon: Icon(
                Icons.bar_chart_rounded,
                size: 36,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GraphPage()));
              },
            ),
          )
        ],
        title: Center(child: Text(APP_NAME)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Welcome back ' + user.firstName.toString() + ',',
                style: TextStyle(fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('How are you feeling today?',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade700)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, bottom: 8),
              child: Text('Pills',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
            ),
            SizedBox(
              height: 160.0,
              child: FutureBuilder(
                  future: PillsRepository().fetchPills(
                      emailAddress:
                          Provider.of<User>(context).emailAddress.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var pills = snapshot.data as List<Pills>;
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: pills.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Card(
                                child: pillsCard(
                                  medName: pills[index].pillName,
                                  time: pills[index].pillTime,
                                ),
                              ),
                            ),
                          ),
                          addPillCard(user)
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return Text('Nothing Returned');
                    }
                  }),
            ),
            Text(
              'Demo Headline 2',
              style: TextStyle(fontSize: 18),
            ),
            Card(
              child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle: Text('this is a description of the motivation')),
            ),
            Card(
              child: ListTile(
                  title: Text('Motivation $int'),
                  subtitle: Text('this is a description of the motivation')),
            ),
          ],
        ),
      ),
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

  Widget addPillCard(user) {
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
                  create: (context) => user,
                  child: AddPill(),
                ),
              ),
            );
          },
          //INFO: This is in-case to work again on the notifications.
          // onPressed: () {
          //   // model.instantNotification(
          //   //     title: 'Morning pill Reminder',
          //   //     subtitle: 'It\'s time for Morning pill');
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //     content: Text('Suscribed to the notifications'),
          //   ));
          //   // model.scheduleNotification(
          //   //     title: 'Morning Pill Reminder', body: "Take the goddam pill");
          //   model.schedulePillsNotification();
          // },
        ),
      ),
    );
  }
}
