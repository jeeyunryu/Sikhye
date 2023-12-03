import 'package:flutter/material.dart';

import 'conditionalSearch.dart';
import 'detail.dart';
import 'bookmarks.dart';
import 'profile.dart';
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
            // title: const Text('Home'),
            // backgroundColor: Colors.purple.shade50,
            // leading: const Icon(Icons.menu),
            actions: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              ),
              IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MarkedPage()));
                  }),
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
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
                title: Text('조건 검색'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConditionalSearch()));
                })
          ],
        )),
        // body: <Widget>[
        //   SearchScreen(products: products),
        //   FavoritePage(),
        // ][currentPageIndex]);
        body: ListView(children: [
          SizedBox(
            height: 150,
          ),
          Center(child: Text('Sikhye', style: TextStyle(fontSize: 30))),
          SizedBox(
            height: 100,
          ),
          SearchScreen(),
        ]));
  }
}
