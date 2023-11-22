import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sikhye/home.dart';
import 'package:sikhye/signIn.dart';

import 'horizontalBarChart.dart';
import 'organizedCard.dart';
import 'searchResult.dart';
import 'signIn.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.rowFromJson});
  final RowFromJson rowFromJson;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text('Sikhye'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Image.asset('assets/default-image.jpg'),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/default-image.jpg'),
                    ),
                  ),
                ),
                // Image.asset('assets/default-image.jpg', width: 50, height: 50),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.rowFromJson.bSSHNM!),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.favorite_border_outlined),
                    onPressed: () {
                      if (FirebaseAuth.instance.currentUser == null)
                        showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("로그인 후 사용해주십시오"),
                                content: const Text("저장 기능은 회원에게만 제공됩니다. "),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text("로그인"),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignInPage(),
                                        ),
                                      );
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("취소"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                    }),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            alignment: Alignment.centerLeft,
            child: Text(widget.rowFromJson.pRDLSTNM!),
          ),
          OrganizedCard(widget.rowFromJson),
        ],
      ),
    );
  }
}
