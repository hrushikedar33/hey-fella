import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/helper/constants.dart';
import 'package:hey_fellas/services/database.dart';
import 'package:hey_fellas/ui/screens/chats/chat_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DatabaseMethods _databaseMethods = DatabaseMethods();

  TextEditingController _searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

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

  Widget searchList() {
    return haveUserSearched
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return searchTile(
                searchSnapshot.documents[index].data['name'],
                searchSnapshot.documents[index].data['email'],
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
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontFamily: 'Docker',
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                  fontFamily: 'Docker',
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendRequest(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.blue,
              ),
              child: Text(
                'Request',
                style: TextStyle(
                  fontFamily: 'Docker',
                  fontSize: 16.0,
                  color: Colors.white,
                ),
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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
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
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              print('Menu button pressed');
            },
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
                padding: EdgeInsets.all(8.0),
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
                          horizontal: 20.0, vertical: 10.0),
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
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.greenAccent,
                                  Colors.green,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.search),
                              iconSize: 20.0,
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
                          horizontal: 20.0, vertical: 10.0),
                      child: searchList(),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
