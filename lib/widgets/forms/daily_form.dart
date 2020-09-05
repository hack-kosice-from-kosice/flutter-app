import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            height: 50.0,
          ),
          Column(
            children: [
              Text('How would you rate your sleep?',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                ),),
              FluidSlider(
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
              Text('Do you feel rested?',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                ),),
              FluidSlider(
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
                Text('Are you pain free?',
          style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
          ),),
                FluidSlider(
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
            child: new Container(
              width: double.infinity,
              child: RaisedButton(
                  color: Colors.grey,
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },

                child: Text('Submit', style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
