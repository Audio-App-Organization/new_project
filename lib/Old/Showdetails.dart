// ignore: file_names
import 'package:flutter/material.dart';
//import 'package:new_project/dashboard.dart';
import 'package:new_project/addPatient.dart';
import 'package:new_project/editPatient.dart';
import 'package:new_project/recording.dart';
import 'package:new_project/voicerecordera.dart';
//import 'package:new_project/voicerecordera.dart';
//import 'package:new_project/voicerecordera.dart';

class ShowDetails extends StatelessWidget {
  final String id, name, tpnumber, birthday;
  final List<String> history;
  const ShowDetails(
      {super.key,
      required this.id,
      required this.name,
      required this.birthday,
      required this.tpnumber,
      required this.history});

  @override
  Widget build(BuildContext context) {
    // Simply Display Each Data Point

    TextEditingController _id = TextEditingController(text: id);
    TextEditingController _name = TextEditingController(text: name);
    TextEditingController _birthday = TextEditingController(text: birthday);
    TextEditingController _tpnumber = TextEditingController(text: tpnumber);

    TextEditingController _history = TextEditingController(text: history.toString());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Patient Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit), onPressed: () {  },
            )
          ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: _id,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "ID Number",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: _name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: _birthday,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Age",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: _tpnumber,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Telephone Number",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: _history,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "Medical History",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddPatient()),
                );
                Align(
                  alignment: Alignment.bottomLeft,
                );
              },
              child: const Text("Edit Profile"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Voice()),
                );
                Align(
                  alignment: Alignment.bottomLeft,
                );
              },
              child: const Text("Get Voice Sample"),
            ),
          ],
        ),
      ),
    );
  }
}
