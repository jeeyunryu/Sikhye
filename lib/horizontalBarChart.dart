import 'package:flutter/material.dart';

class HorizontalBarChart extends StatefulWidget {
  final noAllergy;

  final noWarning;
  final splitted;

  HorizontalBarChart(this.noAllergy, this.noWarning, this.splitted,
      {super.key});

  @override
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> chartData = [
      // {
      //   'units': 50,
      //   'color': Colors.green,
      // },
      {
        'units': widget.noAllergy,
        'color': Colors.orange,
      },
      {
        'units': widget.noWarning,
        'color': Colors.red,
      },
      {
        'units': widget.splitted.length - widget.noAllergy - widget.noWarning,
        'color': Colors.grey,
      },
    ];
    double maxWidth = MediaQuery.of(context).size.width - 36;
    var totalUnitNum = widget.splitted.length;
    // for (int i = 0; i < chartData.length; i++) {
    //   totalUnitNum = totalUnitNum + int.parse(chartData[i]['units'].toString());
    // }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Row(children: [
            for (int i = 0; i < chartData.length; i++)
              i == chartData.length - 1
                  ? Expanded(
                      child: SizedBox(
                        height: 16,
                        child: ColoredBox(
                          color: chartData[i]['color'],
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width:
                              chartData[i]['units'] / totalUnitNum * maxWidth,
                          height: 16,
                          child: ColoredBox(
                            color: chartData[i]['color'],
                          ),
                        ),
                      ],
                    )
          ])),
    );
  }
}
