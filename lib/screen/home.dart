import 'package:authentication_6135512041/screen/login.dart';
import 'package:authentication_6135512041/screen/register.dart';
import 'package:flutter/material.dart';

class HomeScree extends StatelessWidget {
  const HomeScree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("BTJ travel")),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/LOGO.png"),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) {
                        return RegisterScreen();
                      })
                      );
                    },
                    icon: Icon(Icons.add),
                    label:
                        Text("Create Account", style: TextStyle(fontSize: 20))
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) {
                        return LoginScreen();
                      })
                      );
                    },
                    icon: Icon(Icons.login),
                    label: Text("Log In", style: TextStyle(fontSize: 20))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
