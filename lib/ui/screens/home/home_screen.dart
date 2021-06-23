import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/helper/constants.dart';
import 'package:hey_fellas/helper/helperFunction.dart';
import 'package:hey_fellas/services/database.dart';
import 'package:hey_fellas/ui/screens/home/search_screen.dart';
import 'package:hey_fellas/ui/screens/widgets/category_selector.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';
import 'package:hey_fellas/ui/screens/widgets/navdrawer.dart';
import 'package:hey_fellas/ui/screens/widgets/recent_chats.dart';
import 'package:hey_fellas/ui/theme/themecolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final AuthServices _auth = AuthServices();
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColor.black,
          ),
          child: Container(width: Sizes.dimen_250.w, child: NavDrawer())),
      appBar: AppBar(
        // leading: IconButton(.
        //   icon: Icon(Icons.menu),
        //   iconSize: Sizes.dimen_28.w,
        //   color: Colors.white, //todo
        //   onPressed: () async {
        //     await _auth.signOut();
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return Authantication();
        //         },
        //       ),
        //     );
        //   },
        // ),
        iconTheme: (IconThemeData(
          color: Colors.red, //todo change color
        )),
        title: Center(
          //change required
          child: Text(
            'hey fellas!',
            style: Theme.of(context)
                .textTheme
                .headline5
                .apply(color: Theme.of(context).unselectedWidgetColor),
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            iconSize: Sizes.dimen_28.w,
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
                  // FavouriteContacts(),
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
