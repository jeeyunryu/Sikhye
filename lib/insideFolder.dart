import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'detail.dart';
import 'searchResult.dart';

class InsideFolder extends StatelessWidget {
  const InsideFolder(this.folderName, {super.key});

  final folderName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('\'$folderName\' 폴더'),
          centerTitle: true,
        ),
        body: Consumer<ApplicationState>(builder: (context, appState, _) {
          final productsInFolder = appState.likes.where((e) {
            return e.folder == folderName;
          });
          print('test $productsInFolder');
          print('likes ${appState.likes}');

          return ListView(children: [
            ...productsInFolder.map((e) {
              return FutureBuilder<Autogenerated>(
                  future: fetchProducts('PRDLST_REPORT_NO', e.productId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final filteredProduct = snapshot.data!.c002!.row!.first;
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          rowFromJson: filteredProduct,
                                        )));
                          },
                          child: Card(
                              child: Row(
                            children: [
                              Image.asset('assets/default-image.jpg',
                                  width: 100),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(filteredProduct.bSSHNM!),
                                    Text(filteredProduct.pRDLSTNM!),
                                  ],
                                ),
                              )
                            ],
                          )));
                    } else if (snapshot.hasError) {
                      return Text('snapshot error: ${snapshot.hasError}');
                    }
                    return const Center(child: CircularProgressIndicator());
                  });
            }),
          ]);
        }));
  }
}
