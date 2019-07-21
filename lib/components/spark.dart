/// Spark Bar Example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Example of a Spark Bar by hiding both axis, reducing the chart margins.
class SparkBar extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SparkBar(this.seriesList, {this.animate});

  factory SparkBar.withSampleData() {
    return new SparkBar(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,

      primaryMeasureAxis:
      new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),

      domainAxis: new charts.OrdinalAxisSpec(
        // Make sure that we draw the domain axis line.
          showAxisLine: true,
          // But don't draw anything else.
          renderSpec: new charts.NoneRenderSpec()),

      // With a spark chart we likely don't want large chart margins.
      // 1px is the smallest we can make each margin.
      layoutConfig: new charts.LayoutConfig(
          leftMarginSpec: new charts.MarginSpec.fixedPixel(0),
          topMarginSpec: new charts.MarginSpec.fixedPixel(0),
          rightMarginSpec: new charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: new charts.MarginSpec.fixedPixel(0)),
    );
  }

  /// Create series list with single series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final globalSalesData = [
      new OrdinalSales('1', 100),
      new OrdinalSales('2', 90),
      new OrdinalSales('3', 80),
      new OrdinalSales('4', 70),
      new OrdinalSales('5', 60),
      new OrdinalSales('6', 50),
      new OrdinalSales('7', 55),
      new OrdinalSales('8', 40),
      new OrdinalSales('9', 30),
      new OrdinalSales('10', 10),
      new OrdinalSales('11', 10),
      new OrdinalSales('12', 10),
      new OrdinalSales('13', 10),
      new OrdinalSales('14', 10),
      new OrdinalSales('15', 10),
      new OrdinalSales('16', 10),
      new OrdinalSales('17', 10),
      new OrdinalSales('18', 10),
      new OrdinalSales('19', 10),
      new OrdinalSales('12', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,

      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}