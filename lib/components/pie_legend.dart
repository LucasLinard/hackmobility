/// Bar chart with series legend example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimpleDatumLegend extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleDatumLegend(this.seriesList, {this.animate});

  factory SimpleDatumLegend.withSampleData() {
    return new SimpleDatumLegend(
      _createSampleData(),
      animate: true,

    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: charts.PieChart(
        seriesList,
        animate: animate,
        behaviors: [new charts.DatumLegend()],
      ),
    );
  }

  /// Create series list with one series
  static List<charts.Series<ModalEmissions, String>> _createSampleData() {
    final data = [
      new ModalEmissions(0, 100, 'Car'),
      new ModalEmissions(1, 25, 'Bike'),
      new ModalEmissions(2, 45, 'Public Transport'),
      new ModalEmissions(3, 67, 'Carpool'),
    ];

    return [
      new charts.Series<ModalEmissions, String>(
        id: 'Sales',
        domainFn: (ModalEmissions sales, _) => sales.name,
        measureFn: (ModalEmissions sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class ModalEmissions {
  final String name;
  final int year;
  final int sales;

  ModalEmissions(this.year, this.sales, this.name);
}
