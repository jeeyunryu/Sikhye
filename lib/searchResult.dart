import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'detail.dart';

class Autogenerated {
  C002? c002;

  Autogenerated({this.c002});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    c002 = json['C002'] != null ? new C002.fromJson(json['C002']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.c002 != null) {
      data['C002'] = this.c002!.toJson();
    }
    return data;
  }
}

class C002 {
  String? totalCount;
  List<RowFromJson>? row;
  RESULT? rESULT;

  C002({this.totalCount, this.row, this.rESULT});

  C002.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['row'] != null) {
      row = <RowFromJson>[];
      json['row'].forEach((v) {
        row!.add(new RowFromJson.fromJson(v));
      });
    }
    rESULT =
        json['RESULT'] != null ? new RESULT.fromJson(json['RESULT']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.row != null) {
      data['row'] = this.row!.map((v) => v.toJson()).toList();
    }
    if (this.rESULT != null) {
      data['RESULT'] = this.rESULT!.toJson();
    }
    return data;
  }
}

class RowFromJson {
  String? pRDLSTREPORTNO;
  String? pRMSDT;
  String? lCNSNO;
  String? pRDLSTNM;
  String? bSSHNM;
  String? pRDLSTDCNM;
  String? cHNGDT;
  String? rAWMTRLNM;

  RowFromJson(
      {this.pRDLSTREPORTNO,
      this.pRMSDT,
      this.lCNSNO,
      this.pRDLSTNM,
      this.bSSHNM,
      this.pRDLSTDCNM,
      this.cHNGDT,
      this.rAWMTRLNM});

  RowFromJson.fromJson(Map<String, dynamic> json) {
    pRDLSTREPORTNO = json['PRDLST_REPORT_NO'];
    pRMSDT = json['PRMS_DT'];
    lCNSNO = json['LCNS_NO'];
    pRDLSTNM = json['PRDLST_NM'];
    bSSHNM = json['BSSH_NM'];
    pRDLSTDCNM = json['PRDLST_DCNM'];
    cHNGDT = json['CHNG_DT'];
    rAWMTRLNM = json['RAWMTRL_NM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PRDLST_REPORT_NO'] = this.pRDLSTREPORTNO;
    data['PRMS_DT'] = this.pRMSDT;
    data['LCNS_NO'] = this.lCNSNO;
    data['PRDLST_NM'] = this.pRDLSTNM;
    data['BSSH_NM'] = this.bSSHNM;
    data['PRDLST_DCNM'] = this.pRDLSTDCNM;
    data['CHNG_DT'] = this.cHNGDT;
    data['RAWMTRL_NM'] = this.rAWMTRLNM;
    return data;
  }
}

class RESULT {
  String? mSG;
  String? cODE;

  RESULT({this.mSG, this.cODE});

  RESULT.fromJson(Map<String, dynamic> json) {
    mSG = json['MSG'];
    cODE = json['CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MSG'] = this.mSG;
    data['CODE'] = this.cODE;
    return data;
  }
}

Future<Autogenerated> fetchProducts(String searchKeyword, String text) async {
  // String product = '새우깡';

  final response = await http.get(Uri.parse(
      'https://openapi.foodsafetykorea.go.kr/api/2d72697d0d2747119655/C002/json/1/30/$searchKeyword=\'$text\''));

  if (response.statusCode == 200) {
    // return (jsonDecode(response.body) as List)
    //     .map((e) => Autogenerated.fromJson(e))
    //     .toList();
    return Autogenerated.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class ProductsWidget extends StatefulWidget {
  const ProductsWidget(this.text, {super.key});

  final String text;

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  late Future<Autogenerated> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts('PRDLST_NM', widget.text);
  }

  @override
  Widget build(BuildContext context) {
    List<RowFromJson> filteredLists = <RowFromJson>[];

    return FutureBuilder<Autogenerated>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // for (int i = 0;
            //     i < int.parse(snapshot.data!.c002!.totalCount!);
            //     i++) {
            //   if (snapshot.data!.c002!.row![i].pRDLSTNM!
            //       .contains(widget.text)) {
            //     filteredLists.add(snapshot.data!.c002!.row![i]);
            //   }
            // }
            // final filteredLists = snapshot.data!.c002!.row!.where((e) {
            //   return e.pRDLSTNM!.contains(widget.text);
            // });
            final filteredLists = snapshot.data!.c002!.row;
            if (filteredLists == null) {
              return Center(child: const Text('검색 결과 없음'));
            }
            return ListView(
              children:
                  // Text('\'${widget.text}\'에 대한 검색결과'),
                  filteredLists
                      .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          rowFromJson: e,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        width: 220,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(e.bSSHNM!),
                                            SizedBox(height: 10),
                                            Text(e.pRDLSTNM!,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                // Text(e.rAWMTRLNM!),
                              ],
                            )),
                          )))
                      .toList(),

              // ...snapshot.data!.c002!.row!.map((e) => SizedBox(
              //       width: double.infinity,
              //       child: Card(
              //         elevation: 4,
              //         child: Column(
              //           children: [
              //             Text(e.pRDLSTNM!),
              //             Text(e.bSSHNM!),
              //             Text(e.rAWMTRLNM!),
              //           ],
              //         ),
              //       ),
              //     )),
            );
          } else if (snapshot.hasError) {
            return Text('snapshot error: ${snapshot.hasError}');
          }
          return Center(child: const CircularProgressIndicator());
        });
  }
}

class Product {
  String brand;
  String name;
  int weight;

  Product(this.brand, this.name, this.weight);
}

class SearchResultPage extends StatefulWidget {
  SearchResultPage(this.text, {super.key});

  final String text;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  // late Future<Autogenerated> futureProducts;

  // @override
  // void initState() {
  //   super.initState();
  //   futureProducts = fetchProducts();
  // }

  // final List<Product> products = <Product>[
  //   Product('오리온', '초코파이 바나나', 444),
  //   Product('오리온', '초코파이 정', 468),
  //   Product('오리온', '초코파이 하우스', 320),
  //   Product('노브랜드', '초코파이', 500),
  //   Product('롯데', '초코파이', 500),
  // ];

  // List<Product> filteredProducts = <Product>[];

  @override
  Widget build(BuildContext context) {
    // List<RowFromJson> filteredLists = <RowFromJson>[];

    // for (int i = 0; i < products.length; i++) {
    //   if (products[i].name.contains(widget.text)) {
    //     filteredProducts.add(products[i]);
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        // title: Text('Search'),
        centerTitle: true,
      ),
      body: ProductsWidget(widget.text),
      // body: ListView(
      //   children: filteredProducts.map(
      //     (product) {
      //       return GestureDetector(
      //         onTap: () {
      //           // Navigator.pushNamed(context, '/detail', arguments: product);
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => DetailPage(
      //                         product: product,
      //                       )));
      //         },
      //         child: Card(
      //             // child: Text(product.brand),
      //             child: Row(children: [
      //           Image.asset(
      //               // width: 100,
      //               height: 100,
      //               'assets/default-image.jpg',
      //               fit: BoxFit.fill),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 18.0),
      //             child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(product.brand),
      //                   Text(product.name),
      //                   Text(product.weight.toString()),
      //                 ]),
      //           ),
      //         ])),
      //       );
      //     },
      //   ).toList(),
      // ),
    );
  }
}
