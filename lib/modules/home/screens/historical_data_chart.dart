import 'package:currency_app/modules/home/controllers/home_controller.dart';
import 'package:currency_app/modules/home/models/historical_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoricalDataChart extends StatelessWidget
{
  const HistoricalDataChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          primaryYAxis: NumericAxis(
            decimalPlaces: 8
          ),
          series: <ChartSeries<HistoricalData,DateTime>>
          [
            SplineSeries<HistoricalData,DateTime>(
              dataSource: _.historicalData,
               xValueMapper: (HistoricalData data, xValue) => data.periodEnd,
                yValueMapper: (HistoricalData data, yValue) => data.price)
          ]
        );
      }
    );
  }
  
}