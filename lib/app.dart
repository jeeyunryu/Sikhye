import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home.dart';
import 'ingredients.dart';
import 'signIn.dart';

class App extends StatelessWidget {
  const App({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shikhye',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/signIn': (BuildContext context) => const SignInPage(),
      },
    );
  }
}

// final _router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomePage(),
//       routes: [

//       ],
//     ),
//   ],
// )
