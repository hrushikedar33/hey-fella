import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/ui/screens/home/home_screen.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  Timer timer;
  // bool _isVerified;

  @override
  void initState() {
    _user = _auth.currentUser;
    _user.sendEmailVerification();
    // _isVerified = false;
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "Email has been send to you ${_user.emailVerified} \n Please check"),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    _user = _auth.currentUser;
    await _user.reload();
    if (_user.emailVerified) {
      timer.cancel();
      // _isVerified = true;
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => HomeScreen(),
      //   ),
      // );
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ));
    }
  }
}
