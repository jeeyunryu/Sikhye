import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sikhye/home.dart';
import 'package:sikhye/signIn.dart';

import 'app_state.dart';
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
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        // title: const Text('Sikhye'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.rowFromJson.bSSHNM!),
                  ),
                ),
                Consumer<ApplicationState>(builder: (context, appState, _) {
                  bool isMarked() {
                    for (var p in appState.likes) {
                      if (widget.rowFromJson.pRDLSTREPORTNO == p.productId) {
                        return true;
                      }
                    }
                    return false;
                  }

                  return IconButton(
                      icon: isMarked()
                          ? const Icon(Icons.bookmark)
                          : const Icon(Icons.bookmark_border_outlined),
                      onPressed: () {
                        if (FirebaseAuth.instance.currentUser == null) {
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
                        } else if (!isMarked()) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0))),
                                  child: ListView(shrinkWrap: true, children: [
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text('즐겨찾기 폴더에 추가',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        )),
                                    const Divider(
                                      height: 20,
                                      thickness: 0.5,
                                      // indent: 20,
                                      // endIndent: 0,
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.folder),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: TextField(
                                              controller: _controller,
                                              decoration: InputDecoration(
                                                hintText: '폴더명을 입력하세요',
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 20,
                                      thickness: 0.5,
                                      // indent: 20,
                                      // endIndent: 0,
                                      color: Colors.black,
                                    ),
                                    ...appState.folders.map<Widget>((e) {
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Icon(Icons.folder),
                                          ),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(e),
                                          )),
                                          IconButton(
                                            icon: Icon(Icons.check),
                                            onPressed: () {
                                              appState.addLikes(
                                                  e, widget.rowFromJson);
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    }),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                              child: Text('취소'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              )))),
                                        ),
                                        Expanded(
                                          child: OutlinedButton(
                                              child: Text('확인'),
                                              onPressed: () {
                                                appState.addLikes(
                                                    _controller.text,
                                                    widget.rowFromJson);
                                                appState.folders
                                                    .add(_controller.text);
                                                Navigator.pop(context);
                                              },
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              )))),
                                        ),
                                      ],
                                    ),
                                  ])));
                          // Row(
                          //   children: [

                          //   ],
                          // )
                          // appState.addLikes(widget.rowFromJson);
                        } else if (isMarked()) {
                          appState.deleteMarks(widget.rowFromJson);
                        }
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
          OrganizedCard(true, widget.rowFromJson),
        ],
      ),
    );
  }
}
