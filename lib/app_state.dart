import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'add.dart';
import 'firebase_options.dart';

class Product {
  String name;
  String brand;
  int weight;
  String material;

  Product(
      {required this.name,
      required this.brand,
      requir,
      required this.weight,
      required this.material});
}

class ApplicationState extends ChangeNotifier {
  List<Product> products = [];

  ApplicationState() {
    init();
  }

  void addProduct(ProductToAdd productToAdd) {
    FirebaseFirestore.instance.collection('products').add(<String, dynamic>{
      'name': productToAdd.name,
      'brand': productToAdd.brand,
      'weigt': productToAdd.weight,
      'material': productToAdd.material,
    });
  }

  init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
