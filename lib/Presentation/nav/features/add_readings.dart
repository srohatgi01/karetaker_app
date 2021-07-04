import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/health_stats_repo.dart';
import 'package:provider/provider.dart';

class AddReading extends StatefulWidget {
  const AddReading({Key? key, required this.readingType}) : super(key: key);

  final String readingType;

  @override
  _AddReadingState createState() => _AddReadingState();
}

class _AddReadingState extends State<AddReading> {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 100, 40, 20),
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  labelText: "Enter Reading Value",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: new TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(PRIMARY_COLOR),
                ),
                child: TextButton(
                  child: Text(
                    'Add Reading',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () => {
                    if (widget.readingType == 'sugar')
                      {
                        HealthStatsRepo().createSugarReading(
                          userId: user.emailAddress,
                          readingValue: textController.value.text,
                        )
                      }
                    else if (widget.readingType == 'bp')
                      {
                        HealthStatsRepo().createBloodPressureReading(
                          userId: user.emailAddress,
                          readingValue: textController.value.text,
                        )
                      }
                    else if (widget.readingType == 'heartrate')
                      {
                        HealthStatsRepo().createHeartRateReading(
                          userId: user.emailAddress,
                          readingValue: textController.value.text,
                        ),
                      },
                    Navigator.pop(context),
                    ScaffoldMessenger(
                        child: SnackBar(
                            content: Text('Reading Added Successfully'))),
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(widget.readingType == 'sugar'
          ? 'Add Sugar Reading'
          : widget.readingType == 'bp'
              ? 'Add Blood Pressure Reading'
              : 'Add Heart Rate Reading'),
    );
  }
}
