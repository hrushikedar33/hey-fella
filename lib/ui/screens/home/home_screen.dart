import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/helper/constants.dart';
import 'package:hey_fellas/helper/helperFunction.dart';
import 'package:hey_fellas/services/auth.dart';
import 'package:hey_fellas/services/database.dart';
import 'package:hey_fellas/ui/screens/auth/authantication.dart';
import 'package:hey_fellas/ui/screens/home/search_screen.dart';
import 'package:hey_fellas/ui/screens/widgets/category_selector.dart';
import 'package:hey_fellas/ui/screens/widgets/recent_chats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthServices _auth = AuthServices();
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  Stream<QuerySnapshot> chatRooms;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    _databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRooms = value;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () async {
            await _auth.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Authantication();
                },
              ),
            );
          },
        ),
        title: Center(
          //change required
          child: Text(
            'hey fellas!',
            style: TextStyle(
              color: Color(0xFFfca311),
              fontFamily: 'Docker',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  //FavouriteContacts(),
                  RecentChats(
                    chatRooms: chatRooms,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
