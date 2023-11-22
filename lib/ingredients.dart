import 'dart:ffi';

import 'package:flutter/material.dart';

import 'organizedCard.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key, required this.splitted});

  final splitted;

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  @override
  Widget build(BuildContext context) {
    int noIngredients = widget.splitted.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sikhye'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // OrganizedCard(),
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
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text('1'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.splitted[i]),
                        Text('혼합목적: '),
                      ],
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
