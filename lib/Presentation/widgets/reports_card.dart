import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';

class ReportsCard extends StatefulWidget {
  final doctorName;
  final date;
  final reportName;
  final currentStatus;
  const ReportsCard({
    Key? key,
    required this.doctorName,
    required this.date,
    required this.reportName,
    required this.currentStatus,
  }) : super(key: key);

  @override
  _ReportsCardState createState() => _ReportsCardState();
}

class _ReportsCardState extends State<ReportsCard> {
  @override
  Widget build(BuildContext context) {
    bool status = widget.currentStatus;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.reportName}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Report by',
                style: TextStyle(
                  fontSize: 18,
                )),
            Text('Dated',
                style: TextStyle(
                  fontSize: 18,
                ))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Dr. ${widget.doctorName}',
              style: TextStyle(
                fontSize: 20,
                color: Color(PRIMARY_COLOR),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${widget.date}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
          SizedBox(height: 20),
          Divider(),
          Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('HIDE'),
                Switch(
                    value: status,
                    onChanged: (value) {
                      status = value;
                      setState(() {});
                    }),
                Text('SHOW'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
