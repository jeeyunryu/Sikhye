import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'home.dart';
import 'signIn.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var isLoggedIn;

    if (FirebaseAuth.instance.currentUser == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          isLoggedIn
              ? Consumer<ApplicationState>(builder: (context, appState, _) {
                  return IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      GoogleSignIn _googleSignIn = GoogleSignIn();
                      await _googleSignIn.disconnect();
                      appState.init();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  );
                })
              : SizedBox()
        ]),
        body: isLoggedIn
            ? Center(
                child: Column(children: [
                  Image.network(FirebaseAuth.instance.currentUser!.photoURL!,
                      width: 100, height: 100),
                  Text(FirebaseAuth.instance.currentUser!.displayName!),
                  Text(FirebaseAuth.instance.currentUser!.uid!),
                ]),
              )
            : Center(
                child: Column(
                  children: [
                    Image.asset('assets/blank-profile-picture.png',
                        width: 100, height: 100),
                    Text('Guest'),
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
