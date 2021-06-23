import 'package:flutter/material.dart';
import 'package:hey_fellas/ui/screens/auth/login_sacreen.dart';
import 'package:hey_fellas/ui/screens/auth/signup_screen.dart';

class Authantication extends StatefulWidget {
  @override
  _AuthanticationState createState() => _AuthanticationState();
}

class _AuthanticationState extends State<Authantication> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserModel>(context);

    if (showSignIn) {
      return LoginScreen(toggleView: toggleView);
    } else {
      return SignupScreeen(toggleView: toggleView);
    }
  }
}
