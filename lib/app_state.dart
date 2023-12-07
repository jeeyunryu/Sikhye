import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'add.dart';
import 'firebase_options.dart';
import 'searchResult.dart';

class Product {
  String productId;
  String folder;
  String brand;
  String product;

  Product({
    required this.productId,
    required this.folder,
    required this.brand,
    required this.product,
  });
}

// class Folder {
//   String name;

//   Folder(this.name);
// }

class Event {
  String keyword;
  DateTime date;

  Event({required this.keyword, required this.date});
}

class ApplicationState extends ChangeNotifier {
  List<Product> products = [];
  List<Product> likes = [];
  List<String> folders = [];
  List<Event> events = [];

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
    debugPrint('addedd to firestore');
  }

  void addLikes(String foldername, RowFromJson rowFromJson) {
    FirebaseFirestore.instance.collection('likes').add(<String, dynamic>{
      'folder': foldername,
      'productId': rowFromJson.pRDLSTREPORTNO,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'brand': rowFromJson.bSSHNM,
      'product': rowFromJson.pRDLSTNM,
    });
  }

  void addSearches(DateTime date, String text) {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance.collection('searches').add(<String, dynamic>{
        'search': text,
        'date': date,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });
    }
  }

  void deleteMarks(RowFromJson rowFromJson) {
    FirebaseFirestore.instance
        .collection('likes')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('productId', isEqualTo: rowFromJson.pRDLSTREPORTNO)
        .snapshots()
        .listen((e) {
      for (var doc in e.docs) {
        FirebaseFirestore.instance.collection('likes').doc(doc.id).delete();
      }
    });

    // FirebaseFirestore.instance
    //     .collection('likes')
    //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .snapshots()
    //     .listen((event) {
    //   if (FirebaseAuth.instance.currentUser != null) {
    //     likes = [];
    //     for (var doc in event.docs) {
    //       if (FirebaseAuth.instance.currentUser!.uid == doc.data()['uid']) {
    //         likes.add(Product(productId: doc.data()['productId'] as String));
    //       }
    //     }
    //   }
    //   print('updated likes in delete: ${likes.length}');
    //   notifyListeners();
    // });

    // FirebaseFirestore.instance
    //     .collection('likes')
    //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .snapshots()
    //     .listen((event) {
    //   likes = [];
    //   for (var doc in event.docs) {
    //     likes.add(Product(productId: doc.data()['productId'] as String));
    //   }
    //   print('in Delete Mark: ${likes.length}');
    // });
    // notifyListeners();
  }

  // void updateLikes() {
  //   // if (FirebaseAuth.instance.currentUser == null) return;

  //   FirebaseFirestore.instance
  //       .collection('likes')
  //       .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .snapshots()
  //       .listen((event) {
  //     likes = [];
  //     for (var doc in event.docs) {
  //       likes.add(Product(productId: doc.data()['productId'] as String));
  //     }
  //     print(likes.length);
  //   });
  //   notifyListeners();
  // }

  Future<void> init() async {
    likes = [];

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('test.....');

    FirebaseFirestore.instance
        .collection('searches')
        .snapshots()
        .listen((event) {
      if (FirebaseAuth.instance.currentUser != null) {
        events = [];
        for (var doc in event.docs) {
          if (FirebaseAuth.instance.currentUser!.uid == doc.data()['uid']) {
            events.add(Event(
              date: doc.data()['date'].toDate() as DateTime,
              keyword: doc.data()['search'] as String,
            ));
          }
        }
      }
      print('events: ${events}');
    });

    FirebaseFirestore.instance.collection('likes').snapshots().listen((event) {
      if (FirebaseAuth.instance.currentUser != null) {
        likes = [];
        folders = [];
        for (var doc in event.docs) {
          if (FirebaseAuth.instance.currentUser!.uid == doc.data()['uid']) {
            likes.add(Product(
              productId: doc.data()['productId'] as String,
              folder: doc.data()['folder'] as String,
              brand: doc.data()['brand'] as String,
              product: doc.data()['product'] as String,
            ));
            if (!folders.contains(doc.data()['folder'])) {
              folders.add(doc.data()['folder'] as String);
            }
          }
        }
      }
      print('updated likes in init: ${likes.length}');
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      print('user changed!');
      FirebaseFirestore.instance
          .collection('likes')
          // .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((event) {
        if (FirebaseAuth.instance.currentUser != null) {
          likes = [];
          folders = [];
          for (var doc in event.docs) {
            if (FirebaseAuth.instance.currentUser!.uid == doc.data()['uid']) {
              likes.add(Product(
                folder: doc.data()['folder'] as String,
                productId: doc.data()['productId'] as String,
                brand: doc.data()['brand'] as String,
                product: doc.data()['product'] as String,
              ));
              if (!folders.contains(doc.data()['folder'])) {
                folders.add(doc.data()['folder'] as String);
              }
            }
          }
        }
      });

      notifyListeners();
    });
  }
}
