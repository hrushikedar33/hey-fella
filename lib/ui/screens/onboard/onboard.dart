import 'package:flutter/material.dart';
import 'package:hey_fellas/ui/screens/auth/authantication.dart';

class Onboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "onboard screen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 80.0,
          ),
          // Spacer(
          //   flex: 1,
          // ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Authantication();
                },
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.yellow,
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontFamily: "Docker",
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
