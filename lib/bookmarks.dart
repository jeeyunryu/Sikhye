import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sikhye/insideFolder.dart';
import 'package:sikhye/main.dart';

import 'app_state.dart';
import 'searchResult.dart';
import 'detail.dart';
import 'signIn.dart';

class MarkedPage extends StatelessWidget {
  const MarkedPage({super.key});

  @override
  Widget build(BuildContext context) {
    late Future<Autogenerated> futureProducts;
    var isLoggedIn;

    if (FirebaseAuth.instance.currentUser == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('폴더'),
          centerTitle: true,
        ),
        body: isLoggedIn
            ? Consumer<ApplicationState>(builder: (context, appState, _) {
                if (appState.folders.isEmpty) {
                  return Text('저장된 상품이 없습니다.');
                } else {
                  return ListView(
                    children: [
                      ...appState.folders.map((e) {
                        return GestureDetector(
                          child: Container(
                            height: 70,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: const Icon(Icons.folder),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(e),
                                    ),
                                  ],
                                )),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InsideFolder(e)));
                          },
                        );
                      })
                    ],
                  );
                }
              })
            // ? Consumer<ApplicationState>(builder: (context, appState, _) {

            //     return ListView(
            //       children: appState.likes.map((e) {
            //         return FutureBuilder<Autogenerated>(
            //             future: fetchProducts('PRDLST_REPORT_NO', e.productId),
            //             builder: (context, snapshot) {
            //               if (snapshot.hasData) {
            //                 final filteredProduct =
            //                     snapshot.data!.c002!.row!.first;
            //                 return GestureDetector(
            //                     onTap: () {
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) => DetailPage(
            //                                     rowFromJson: filteredProduct,
            //                                   )));
            //                     },
            //                     child: Card(
            //                         child: Row(
            //                       children: [
            //                         Image.asset('assets/default-image.jpg',
            //                             width: 100),
            //                         Padding(
            //                           padding: const EdgeInsets.only(left: 8.0),
            //                           child: Column(
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Text(filteredProduct.bSSHNM!),
            //                               Text(filteredProduct.pRDLSTNM!),
            //                             ],
            //                           ),
            //                         )
            //                       ],
            //                     )));
            //               } else if (snapshot.hasError) {
            //                 return Text('snapshot error: ${snapshot.hasError}');
            //               }
            //               return const Center(
            //                   child: CircularProgressIndicator());
            //             });
            //       }).toList(),
            //     );
            //   })
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('북마크 기능을 이용하기 위해 로그인해주세요'),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ),
                          );
                        },
                        child: Text('로그인')),
                  ],
                ),
              ));
  }
}
