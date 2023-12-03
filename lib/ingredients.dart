import 'dart:ffi';

import 'package:flutter/material.dart';

import 'organizedCard.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage(this.rowFromJson, {super.key, required this.splitted});

  final rowFromJson;

  final splitted;

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
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

  @override
  Widget build(BuildContext context) {
    int noIngredients = widget.splitted.length;

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Sikhye'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          OrganizedCard(false, widget.rowFromJson),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('원재료'),
                SizedBox(width: 10.0),
                Text('${noIngredients}'),
              ],
            ),
          ),
          for (var i = 0; i < noIngredients; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.all(25.0),
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: <Widget>[
                  //       Container(
                  //         width: 50.0,
                  //         height: 50.0,
                  //         decoration: BoxDecoration(
                  //           color: Colors.purple.shade50,
                  //           shape: BoxShape.circle,
                  //         ),
                  //       ),
                  //       Text('1'),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: Builder(builder: (context) {
                      bool isAllergy = false;
                      bool isWarning = false;
                      // print('material: ${widget.splitted[i]}');
                      for (int j = 0; j < loAllergy.length; j++) {
                        // print('allergic material: ${loAllergy[j]}');
                        if (widget.splitted[i].contains(loAllergy[j])) {
                          isAllergy = true;
                          break;
                        }
                        // print('isAllergic material: $isAllergy');
                      }

                      for (int j = 0; j < loWarning.length; j++) {
                        // print('warning material: ${loWarning[j]}');
                        if (widget.splitted[i].contains(loWarning[j])) {
                          isWarning = true;
                          break;
                        }
                        // print('is warning material: $isWarning');
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.splitted[i],
                                ),
                              ),
                              // Text('혼합목적: '),
                              if (isAllergy)
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '*알레르기 주의성분',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              if (isWarning)
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('*12가지 주의성분',
                                      style: TextStyle(color: Colors.orange)),
                                ),
                            ],
                          ))
                        ],
                      );
                    }),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
