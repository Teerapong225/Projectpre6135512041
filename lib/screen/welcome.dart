import 'package:authentication_6135512041/model/profile.dart';
import 'package:authentication_6135512041/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//final auth = FirebaseAuth.instance;
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("BTJ travel")),
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            'Welcome',
            style: TextStyle(fontSize: 25),
          )),
          Text(
            auth.currentUser!.email!,
            style: TextStyle(fontSize: 25),
          ),
          ElevatedButton(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Log Out"),
                  ],
                )),
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeScree();
                }));
              });
            },
          )
        ],
      ),
    );
  }
}
