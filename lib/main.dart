import 'package:flutter/material.dart';
import 'package:hey_fellas/models/userdata/user.dart';
import 'package:hey_fellas/services/auth.dart';
import 'package:hey_fellas/ui/screens/wrapper.dart';
import 'package:provider/provider.dart';
// import 'package:hey_fellas/ui/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        title: 'Hey Fellas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(
              fontFamily: 'Docker',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontFamily: 'Docker',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline3: TextStyle(
              fontFamily: 'Docker',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            subtitle2: TextStyle(
              fontFamily: 'Docker',
              fontSize: 16,
              color: Colors.white70,
            ),
            bodyText1: TextStyle(
              fontFamily: 'Docker',
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
          primaryColor: Color(0xFF000000),
          accentColor: Color(0xFF212529),
        ),
        home: Wrapper(),
      ),
    );
  }
}
