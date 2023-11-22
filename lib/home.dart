import 'package:flutter/material.dart';

import 'detail.dart';
import 'favorites.dart';
import 'searchScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.home),
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //         selectedIcon: Icon(Icons.favorite),
      //         icon: Icon(Icons.favorite_border_outlined),
      //         label: 'Favorites'),
      //     // NavigationDestination(
      //     //   icon: Badge(
      //     //     label: Text('2'),
      //     //     child: Icon(Icons.messenger_sharp),
      //     //   ),
      //     //   label: 'Messages',
      //     // ),
      //   ],
      // ),
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Sikhye'),
          // leading: const Icon(Icons.menu),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //   child: IconButton(
            //     icon: const Icon(Icons.add),
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/add');
            //     },
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5.0),
            //   child: Icon(Icons.person),
            // ),
          ]),
      // body: <Widget>[
      //   SearchScreen(products: products),
      //   FavoritePage(),
      // ][currentPageIndex]);
      body: SearchScreen(),
    );
  }
}
