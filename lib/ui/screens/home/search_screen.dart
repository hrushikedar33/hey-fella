import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/helper/constants.dart';
import 'package:hey_fellas/services/database.dart';
import 'package:hey_fellas/ui/screens/chats/chat_screen.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';
import 'package:hey_fellas/ui/theme/themecolor.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DatabaseMethods _databaseMethods = DatabaseMethods();

  TextEditingController _searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;
  QuerySnapshot allUserSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;
  bool allUserSearched = false;

  @override
  void initState() {
    super.initState();
  }

  initiateSearch() async {
    if (_searchTextEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await _databaseMethods
          .searchByName(_searchTextEditingController.text)
          .then((snapshot) {
        searchSnapshot = snapshot;
        print("$searchSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  userList() async {
    await _databaseMethods.getAllWithUsername().forEach((snapshot) {
      allUserSnapshot = snapshot;
      print("$allUserSnapshot");
      setState(() {
        isLoading = false;
        allUserSearched = true;
      });
    });
  }

  Widget searchList() {
    return haveUserSearched
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return searchTile(
                searchSnapshot.docs[index].data()['name'],
                searchSnapshot.docs[index].data()['email'],
              );
            })
        : Container();
  }

  Widget allUserList() {
    return allUserSearched
        ? ListView.builder(
            itemCount: allUserSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return searchTile(
                allUserSnapshot.docs[index].data()['name'],
                allUserSnapshot.docs[index].data()['email'],
              );
            })
        : Container();
  }

  sendRequest(String userName) {
    print("${Constants.myName}");
    if (userName != Constants.myName) {
      List<String> users = [Constants.myName, userName];

      String chatRoomId = getChatRoomId(Constants.myName, userName);

      Map<String, dynamic> chatRoomMap = {
        'chatroomid': chatRoomId,
        'users': users,
      };
      _databaseMethods.makeRequestToUser(chatRoomId, chatRoomMap);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ChatScreen(
              chatRoomId: chatRoomId,
              chattingWith: chatRoomId
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll(Constants.myName, ""),
            );
          },
        ),
      );
    }
  }

  Widget searchTile(String userName, String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_10.w, vertical: Sizes.dimen_4.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: Colors.white),
              ),
              Text(
                userEmail,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendRequest(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_10.w, vertical: Sizes.dimen_4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.blue,
              ),
              child: Text(
                'Request',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: Sizes.dimen_28.w,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          //change required
          child: Text(
            'hey fellas!',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        elevation: 0.0,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_horiz),
            color: AppColor.black,
            onSelected: (value) {
              print(value);
              // Note You must create respective pages for navigation
              // Navigator.pushNamed(context, value);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => value,
                  ));
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text(
                  "Clear Searches",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .apply(color: AppColor.white),
                ),
                value: SearchScreen(),
              ),

              PopupMenuItem(
                  child: Text(
                    "Report",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .apply(color: AppColor.white),
                  ),
                  value: ""), //todo
              PopupMenuItem(
                  child: Text(
                    "Settings",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .apply(color: AppColor.white),
                  ),
                  value: ""), //todo
            ],
          ),
        ],
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                padding: EdgeInsets.all(Sizes.dimen_8.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_24.w,
                          vertical: Sizes.dimen_2.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchTextEditingController,
                              style: Theme.of(context).textTheme.subtitle1,
                              decoration: InputDecoration(
                                hintText: "search user..",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.greenAccent,
                                  Colors.green,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.search),
                              iconSize: Sizes.dimen_24.w,
                              color: Colors.white,
                              onPressed: () {
                                initiateSearch();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_20.w,
                          vertical: Sizes.dimen_4.h),
                      child: searchList(),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.dimen_10.w,
                                  vertical: Sizes.dimen_4.h),
                              child: allUserList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
