import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'date_interval_type.dart';

class OrderGraphView extends StatefulWidget {
  final List<DateTime> dates;
  const OrderGraphView({super.key, required this.dates});

  @override
  State<OrderGraphView> createState() => _OrderGraphViewState();
}

class _OrderGraphViewState extends State<OrderGraphView> {
  DateIntervalType _selectedRange = DateIntervalType.monthly;

  @override
  Widget build(BuildContext context) {
    final data = _generateData();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<DateIntervalType>(
            value: _selectedRange,
            decoration: InputDecoration(
              labelText: 'Select Range',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            items: DateIntervalType.values.map((DateIntervalType value) {
              return DropdownMenuItem<DateIntervalType>(
                value: value,
                child: Text(value == DateIntervalType.monthly ? 'Monthly' : 'Yearly'),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedRange = newValue!;
              });
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                intervalType: _selectedRange == DateIntervalType.monthly ? DateTimeIntervalType.months : DateTimeIntervalType.years,
                dateFormat: _selectedRange == DateIntervalType.monthly ? DateFormat.yMMM() : DateFormat.y(),
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: const NumericAxis(
                labelFormat: '{value}',
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
              ),
              title: const ChartTitle(
                text: 'Order Metrics',
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ColumnSeries<_ChartData, DateTime>>[
                ColumnSeries<_ChartData, DateTime>(
                  dataSource: data,
                  xValueMapper: (_ChartData sales, _) => sales.date,
                  yValueMapper: (_ChartData sales, _) => sales.count,
                  name: 'Orders',
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<_ChartData> _generateData() {
    Map<String, int> dateCounts = {};
    DateFormat dateFormat = DateFormat.yM();
    if (_selectedRange == DateIntervalType.yearly) {
      dateFormat = DateFormat.y();
    }

    for (var date in widget.dates) {
      String key;
      key = dateFormat.format(date);
      dateCounts[key] = (dateCounts[key] ?? 0) + 1;
    }

    List<_ChartData> data = [];
    dateCounts.forEach((key, value) {
      DateTime date;
      date = dateFormat.parse(key);
      data.add(_ChartData(date, value));
    });

    data.sort((a, b) => a.date.compareTo(b.date));
    return data;
  }
}

class _ChartData {
  _ChartData(this.date, this.count);

  final DateTime date;
  final int count;
}
