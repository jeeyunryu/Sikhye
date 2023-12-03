import 'package:flutter/material.dart';

import 'conditionalSearchResult.dart';

class ConditionalSearch extends StatelessWidget {
  const ConditionalSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final typeController = TextEditingController();
    final ingredientsController = TextEditingController();

    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  TextField(
                    controller: typeController,
                  ),
                  TextField(
                    controller: ingredientsController,
                  ),
                ]),
              ),
            ),
            ElevatedButton(
                child: const Text('검색'),
                onPressed: () {
                  // Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const ConditionalSearchResult()));
                })
          ])
        ]));
  }
}
