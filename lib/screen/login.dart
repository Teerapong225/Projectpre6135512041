import 'package:authentication_6135512041/model/profile.dart';
import 'package:authentication_6135512041/screen/home.dart';
import 'package:authentication_6135512041/screen/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Log In"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 200.0,
                              height: 200.0,
                              child: Image.asset("assets/images/LOGO.png"),
                            ),
                          ),
                          Text("E-mail", style: TextStyle(fontSize: 15)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                      "Please enter your email address."),
                              EmailValidator(
                                  errorText: "The email format is invalid.")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (var email) {
                              profile.email = email;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Password", style: TextStyle(fontSize: 15)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "Please enter your password."),
                            obscureText: true,
                            onSaved: (var password) {
                              profile.password = password;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("Log In",
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value){
                                          formKey.currentState!.reset();
                                          Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return WelcomeScreen();
                                      }));
                                        });
                                  } on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                        msg: e.message!,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red);
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
