import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
      String email,
      String password,
      String username,
      bool isLogin,
      BuildContext ctx
      ) async  {
    UserCredential authResult;

    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
      }
    } on PlatformException catch(e) {
      String? message = 'An error occured, please check your credentials!';
      if(e.message != null) {
        message = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message!),
          backgroundColor: Theme.of(context).errorColor,
      )
      );
    } catch(e) {
      print(e);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitForm: _submitAuthForm),
    );
  }
}
