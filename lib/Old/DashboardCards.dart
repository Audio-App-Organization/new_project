// Simple widget with a safearea with text named patient"


import 'package:flutter/material.dart';

import '../Searchpatient.dart';
import '../addPatient.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Card(
                      color: Color.fromARGB(255, 94, 167, 193),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/medical.png", width: 64.0),
                              const SizedBox(height: 10.0),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddPatient()));
                                  },
                                  child: Text(
                                    "Set Patient Details",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160.0,
                    height: 160.0,
                    child: Card(
                      color: Color.fromARGB(255, 32, 101, 157),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/research.png", width: 64.0),
                              const SizedBox(height: 10.0),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Searchpatient()));
                                  },
                                  child: Text(
                                    "Search Patient Details",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]
        ,
      )
      ,
    )
    ,