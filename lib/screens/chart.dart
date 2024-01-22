import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  final List<Map<String, int>> data;

  ChartWidget(this.data);

  @override
  Widget build(BuildContext context) {
    List<int> dataa = [];
    data.forEach((element) {
      dataa.add(element.values.first);
    });
    //print(data);
    //print(dataa);

    return Center(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
          LineSeries<int, String>(
            dataSource: dataa,
            xValueMapper: (entry, index) => data[index].keys.first,
            yValueMapper: (entry, _) => entry,
          ),
        ],
      ),
    );
  }
}
