import 'package:flutter/material.dart';
import 'package:hey_fellas/models/userdata/user.dart';
import 'package:hey_fellas/ui/screens/home/home_screen.dart';
import 'package:hey_fellas/ui/screens/onboard/onboard.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Onboard();
    } else {
      return HomeScreen();
    }
  }
}
