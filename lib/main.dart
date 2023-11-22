import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sikhye/firebase_options.dart';

// import 'app.dart';
import 'app_state.dart';
import 'home.dart';
import 'add.dart';
// import 'detail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const App()),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shikhye',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/add': (BuildContext context) => const AddProduct(),
        // '/detail': (BuildContext context) => const DetailPage(product: null,),
      },
      theme: ThemeData(useMaterial3: true),
    );
  }
}
