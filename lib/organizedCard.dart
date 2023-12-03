import 'package:flutter/material.dart';
import 'package:sikhye/ingredients.dart';
import 'package:sikhye/searchResult.dart';

import 'horizontalBarChart.dart';

class OrganizedCard extends StatelessWidget {
  const OrganizedCard(
    this.hasIcon,
    this.rowFromJson, {
    super.key,
  });

  final hasIcon;

  final RowFromJson rowFromJson;

  @override
  Widget build(BuildContext context) {
    var splitted = rowFromJson.rAWMTRLNM!.split(',');
    var noWarning = 0;
    var noAllergy = 0;

    List<String> loWarning = ['향', '색소', '아스파탐', '아질산나트륨', '타르'];
    // List<String> loWarning = ['타르'];

    List<String> loAllergy = [
      '난류',
      '우유',
      '메밀',
      '땅콩',
      '대두',
      '밀',
      '고등어',
      '게',
      '새우',
      '돼지고기',
      '복숭아',
      '토마토',
      '아황산류',
      '호두',
      '닭고기',
      '쇠고기',
      '오징어',
      '조개류'
    ];

    for (int i = 0; i < splitted.length; i++) {
      for (int j = 0; j < loAllergy.length; j++) {
        if (splitted[i].contains(loAllergy[j])) {
          noAllergy++;
        }
      }
      for (int j = 0; j < loWarning.length; j++) {
        if (splitted[i].contains(loWarning[j])) {
          noWarning++;
        }
      }
    }
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
                      hasIcon
                          ? IconButton(
                              icon: const Icon(Icons.navigate_next),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IngredientsPage(
                                        rowFromJson,
                                        splitted: splitted),
                                  ),
                                );
                              })
                          : SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: [
                    // const Icon(Icons.fiber_manual_record,
                    //     color: Colors.green, size: 10.0),
                    // const Spacer(
                    //   flex: 2,
                    // ),
                    // const Text('1~2',
                    //     style: TextStyle(color: Colors.green, fontSize: 10)),
                    // const Spacer(
                    //   flex: 2,
                    // ),
                    // const Text('낮은 위험', style: TextStyle(fontSize: 10)),
                    // const Spacer(
                    //   flex: 2,
                    // ),
                    Icon(Icons.fiber_manual_record,
                        color: Colors.orange, size: 10.0),
                    // const Spacer(
                    //   flex: 2,
                    // ),
                    Text('12가지 주의 성분', style: TextStyle(fontSize: 10.0)),
                    const Spacer(
                      flex: 2,
                    ),
                    // const Text('중간 위험', style: TextStyle(fontSize: 10.0)),
                    // const Spacer(
                    //   flex: 2,
                    // ),
                    const Icon(Icons.fiber_manual_record,
                        color: Colors.red, size: 10.0),
                    // const Spacer(
                    //   flex: 2,
                    // ),
                    const Text('알레르기 유발 성분', style: TextStyle(fontSize: 10.0)),
                    const Spacer(
                      flex: 2,
                    ),
                    // const Text('높은 위험', style: TextStyle(fontSize: 10.0)),
                    // const Spacer(
                    //   flex: 2,
                    // ),
                    const Icon(Icons.fiber_manual_record,
                        color: Colors.grey, size: 10.0),
                    // const Spacer(
                    //   flex: 2,
                    // ),
                    const Text('기타', style: TextStyle(fontSize: 10.0)),
                  ]),
                ),
                HorizontalBarChart(noAllergy, noWarning, splitted),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text('원재료'),
                      ),
                      Text('${splitted.length}개'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text('12가지 주의 성분'),
                      ),
                      Text('$noWarning개'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text('알레르기 주의성분'),
                      ),
                      Text('$noAllergy개'),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
