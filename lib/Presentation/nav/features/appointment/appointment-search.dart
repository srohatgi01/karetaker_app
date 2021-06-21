import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/doctor.dart';
import 'package:karetaker/data/provider/search_api.dart';
import 'package:karetaker/data/repositories/search_repo.dart';

class AppointmentSearch extends StatefulWidget {
  const AppointmentSearch({Key? key}) : super(key: key);

  @override
  _AppointmentSearchState createState() => _AppointmentSearchState();
}

class _AppointmentSearchState extends State<AppointmentSearch> {
  TextEditingController textEditingController = TextEditingController();
  var future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Appointment')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchField(textEditingController),
            StreamBuilder(
                stream: Stream.fromFuture(SearchRepo().search(keyword: future)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    var doctors = snapshot.data as List<Doctor>;
                    return buildDoctorCards(docs: doctors);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return initialColumn();
                  }
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  buildDoctorCards({required List<Doctor> docs}) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: docs.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                docs[index].firstName.toString() +
                    ' ' +
                    docs[index].lastName.toString(),
              ),
            ),
          );
        });
  }

  Column initialColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, bottom: 26),
          child: Text('Symptoms',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _card(
                    text: 'Headache',
                    url: 'assets/symptoms/headache.png',
                    onTap: () {
                      print('headache');
                    }),
                _card(
                    text: 'Fatigue',
                    url: 'assets/symptoms/fatigue.png',
                    onTap: () {
                      print('fatigue');
                    }),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _card(
                    text: 'Nausea',
                    url: 'assets/symptoms/nausea.png',
                    onTap: () {
                      print('Nausea');
                    }),
                _card(
                    text: 'Distress',
                    url: 'assets/symptoms/distress.png',
                    onTap: () {
                      print('Distress');
                    }),
              ],
            ),
          ],
        ),
        _viewMoreButton(),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 16, bottom: 26),
          child: Text(
            'Specialities',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _card(
                    text: 'Gynecologist',
                    url: 'assets/symptoms/headache.png',
                    onTap: () {
                      print('Gynecologist');
                    }),
                _card(
                    text: 'Dermatologist',
                    url: 'assets/symptoms/fatigue.png',
                    onTap: () {
                      print('Dermatologist');
                    }),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _card(
                    text: 'Physician',
                    url: 'assets/symptoms/nausea.png',
                    onTap: () {
                      print('General Physician');
                    }),
                _card(
                    text: 'Orthopedic',
                    url: 'assets/symptoms/distress.png',
                    onTap: () {
                      print('Orthopedic');
                    }),
              ],
            ),
          ],
        ),
        _viewMoreButton(),
        SizedBox(height: 50)
      ],
    );
  }

  Padding searchField(TextEditingController textEditingController) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) {
          setState(() {
            future = value;
          });
        },
        style: TextStyle(fontSize: 18),
        controller: textEditingController,
        maxLines: 1,
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search, color: Colors.black),
          alignLabelWithHint: true,
          labelText: 'Search Doctors & Hospitals',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Row _viewMoreButton({onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
            decoration: BoxDecoration(
              color: Color(PRIMARY_COLOR),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              'View more',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector _card(
      {required String text, required String url, required onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            url,
            width: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
