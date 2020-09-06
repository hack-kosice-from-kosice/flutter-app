import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'data/data.dart';

class PlaceholderWidget extends StatelessWidget {
  PlaceholderWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      AnimatedPositioned(
        top: 15,
        left: 110,
        // use top,bottom,left and right property to set the location and Transform.rotate to rotate the widget if needed
        child: Text("Sleep quality",
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w900,
            )),

        duration: Duration(seconds: 3),
      ),
      charts.TimeSeriesChart([
        new charts.Series<TimeSeriesWithIntValue, DateTime>(
          id: 'Desktop',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (TimeSeriesWithIntValue values, _) => values.time,
          measureFn: (TimeSeriesWithIntValue values, _) => values.value,
          data: sleepingStatisticsData,
        )
      ])
    ]);
  }
}

/// Sample time series data type.
class TimeSeriesWithIntValue {
  final DateTime time;
  final int value;

  TimeSeriesWithIntValue(this.time, this.value);
}
