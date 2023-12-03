import 'package:flutter/material.dart';
import 'package:sikhye/home.dart';

import 'detail.dart';
import 'searchResult.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<Autogenerated> futureProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              hintText: 'Search',
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              onSubmitted: (_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchResultPage(controller.text)));
                controller.clear();
              },
              leading: const Icon(Icons.search),
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            // futureProducts = fetchProducts(controller.text);
            //       return FutureBuilder<Autogenerated>(
            //         future: futureProducts,
            //         builder: (context, snapshot) {
            //           if (snapshot.hasData) {
            //             final filteredLists = snapshot.data!.c002!.row!.where((e) {
            //               return e.pRDLSTNM!.contains(controller.text);
            //             });
            //             return List<ListTile>.generate(5, (int index) {
            //               return ListTile(
            //                 title: Text(filteredLists.elementAt(index).pRDLSTNM);
            //                 onTap: (){
            //                   setState(() {
            //                     controller.closeView(filteredLists.elementAt(index).pRDLSTNM);
            //                   });
            //                 },
            //               );
            //             });
            //             // return filteredLists.map((e) => ListTile(
            //             //   title: Text(e.pRDLSTNM!);
            //             // )).toList();
            //           } else if (snapshot.hasError) {
            //   return Text('snapshot error: ${snapshot.hasError}');
            // }
            // return Center(child: const CircularProgressIndicator());
            //         }
            //       );

            return List<ListTile>.generate(1, (int index) {
              // final String item = 'item $index';
              return ListTile(
                title: Text(controller.text),
                onTap: () {
                  setState(() {
                    controller.closeView(controller.text);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchResultPage(controller.text)));
                  });
                },
              );
            });
          }),
        ),
      ],
    );
  }
}
