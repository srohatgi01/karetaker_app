import 'package:flutter/material.dart';
import 'package:karetaker/Presentation/widgets/reports_card.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Medical Records'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(PRIMARY_COLOR),
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              children: [
                ReportsCard(
                  reportName: 'Blood Report',
                  doctorName: 'Hashwant Singh',
                  date: '26-06-2021',
                  currentStatus: true,
                ),
                ReportsCard(
                  reportName: 'Thyroid',
                  doctorName: 'Alok Verma',
                  date: '02-03-2021',
                  currentStatus: false,
                ),
                ReportsCard(
                  reportName: 'BP Pescription',
                  doctorName: 'Alok Verma',
                  date: '16-04-2020',
                  currentStatus: true,
                ),
                ReportsCard(
                  reportName: 'EMR',
                  doctorName: 'Hashwant Singh',
                  date: '01-02-2019',
                  currentStatus: true,
                ),
                ReportsCard(
                  reportName: 'Blood Report',
                  doctorName: 'Hashwant Singh',
                  date: '11-10-2017',
                  currentStatus: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
