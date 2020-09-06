import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

import '../../main.dart';
import 'package:http/http.dart' as http;

class DailyForm extends StatefulWidget {
  @override
  DailyFormState createState() {
    return DailyFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class DailyFormState extends State<DailyForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  double _sleepQuality = 3;
  double _relaxedQuality = 3;
  double _bodyQuality = 3;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              height: 50.0,
            ),
            Column(
              children: [
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                new Container(
                  height: 50.0,
                ),
                Text(
                  'How would you rate your sleep?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FluidSlider(
                  sliderColor: Colors.lightBlue.shade200,
                  value: _sleepQuality,
                  onChanged: (double newValue) {
                    setState(() {
                      _sleepQuality = newValue;
                    });
                  },
                  min: 1,
                  max: 5,
                ),
                new Container(
                  height: 50.0,
                )
              ],
            ),
            Column(
              children: [
                Text(
                  'Do you feel rested?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FluidSlider(
                  sliderColor: Colors.lightBlue.shade200,
                  value: _relaxedQuality,
                  onChanged: (double newValue) {
                    setState(() {
                      _relaxedQuality = newValue;
                    });
                  },
                  min: 1,
                  max: 5,
                ),
                new Container(
                  height: 50.0,
                )
              ],
            ),
            Column(
              children: [
                Text(
                  'Are you pain free?',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                FluidSlider(
                  sliderColor: Colors.lightBlue.shade200,
                  value: _bodyQuality,
                  onChanged: (double newValue) {
                    setState(() {
                      _bodyQuality = newValue;
                    });
                  },
                  min: 1,
                  max: 5,
                ),
                new Container(
                  height: 50.0,
                )
              ],
            ),
            Center(
              child:
              new Container(
                height: 60,
                width: double.infinity - 20,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.lightBlue.shade50,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      double finalStats =
                          (_sleepQuality + _bodyQuality + _relaxedQuality);
                      print(finalStats);
                      sendSleepingStats(1, finalStats);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              ),

          ],
        ),
      ),
    );
  }
}

Future<http.Response> sendSleepingStats(int userId, double value) {
  return http.post(
    'http://ec2-3-122-178-28.eu-central-1.compute.amazonaws.com:8080/users/' +
        userId.toString() +
        '/sleeping-stats',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'value': value.toString(),
    }),
  );
}
