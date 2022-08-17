import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if(value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address'
                      ),
                    ),
                    TextFormField(
                      // validator: (value) {
                      //   if(value.isEmpty || )
                      // }
                      decoration: InputDecoration(
                        labelText: 'Username'
                      )
                    ),
                    TextFormField(
                      validator: (value) {
                        if(value!.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password'
                      )
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text('Log in')
                    ),

                    TextButton(
                      onPressed: () {},
                      child: Text('Create new account'),
                    )
                  ],
                )
              )
            )
          )
        )
      )
    );
  }
}
