import 'package:flutter/material.dart';
import 'package:sikhye/ingredients.dart';
import 'package:sikhye/searchResult.dart';

import 'horizontalBarChart.dart';

class OrganizedCard extends StatelessWidget {
  const OrganizedCard(
    this.rowFromJson, {
    super.key,
  });

  final RowFromJson rowFromJson;

  @override
  Widget build(BuildContext context) {
    var splitted = rowFromJson.rAWMTRLNM!.split(',');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          color: Colors.purple.shade50,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 4.0, bottom: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text('성분 구성'),
                      ),
                      IconButton(
                          icon: const Icon(Icons.navigate_next),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    IngredientsPage(splitted: splitted),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: [
                    const Icon(Icons.fiber_manual_record,
                        color: Colors.green, size: 10.0),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text('1~2',
                        style: TextStyle(color: Colors.green, fontSize: 10)),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text('낮은 위험', style: TextStyle(fontSize: 10)),
                    const Spacer(
                      flex: 2,
                    ),
                    Icon(Icons.fiber_manual_record,
                        color: Colors.yellow.shade700, size: 10.0),
                    const Spacer(
                      flex: 2,
                    ),
                    Text('3~6',
                        style: TextStyle(
                            color: Colors.yellow.shade700, fontSize: 10.0)),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text('중간 위험', style: TextStyle(fontSize: 10.0)),
                    const Spacer(
                      flex: 2,
                    ),
                    const Icon(Icons.fiber_manual_record,
                        color: Colors.red, size: 10.0),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text('7~10',
                        style: TextStyle(color: Colors.red, fontSize: 10.0)),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text('높은 위험', style: TextStyle(fontSize: 10.0)),
                    const Spacer(
                      flex: 2,
                    ),
                    const Icon(Icons.fiber_manual_record,
                        color: Colors.grey, size: 10.0),
                    const Spacer(
                      flex: 2,
                    ),
                    const Text('등급 미정', style: TextStyle(fontSize: 10.0)),
                  ]),
                ),
                const HorizontalBarChart(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('원재료'),
                      ),
                      Text('${splitted.length}개'),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('12가지 주의 성분'),
                      ),
                      Text('2개'),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('알레르기 주의성분'),
                      ),
                      Text('4개'),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
