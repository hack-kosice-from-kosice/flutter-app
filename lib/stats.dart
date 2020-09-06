import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'data/data.dart';

class PlaceholderWidget extends StatelessWidget {

  PlaceholderWidget();

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart([
      new charts.Series<TimeSeriesWithIntValue, DateTime>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesWithIntValue values, _) => values.time,
        measureFn: (TimeSeriesWithIntValue values, _) => values.value,
        data: sleepingStatisticsData,
      )
    ]);
  }
}

/// Sample time series data type.
class TimeSeriesWithIntValue {
  final DateTime time;
  final int value;

  TimeSeriesWithIntValue(this.time, this.value);
}