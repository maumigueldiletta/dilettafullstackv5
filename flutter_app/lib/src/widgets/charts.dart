import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PipelineChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  const PipelineChart({super.key, required this.values, required this.labels});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            barGroups: [
              for (var i=0;i<values.length;i++)
                BarChartGroupData(x:i, barRods:[BarChartRodData(toY: values[i])])
            ],
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles:true)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (x, _) => Padding(
                    padding: const EdgeInsets.only(top:8),
                    child: Text(labels[x.toInt()]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
