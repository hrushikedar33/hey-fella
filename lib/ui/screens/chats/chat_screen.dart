import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/helper/constants.dart';
import 'package:hey_fellas/services/database.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';
import 'package:hey_fellas/ui/screens/home/search_screen.dart';
import 'package:hey_fellas/ui/theme/themecolor.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String chattingWith;

  ChatScreen({this.chatRoomId, this.chattingWith});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  TextEditingController _messageController = new TextEditingController();

  Stream<QuerySnapshot> chatMessageStream;

  @override
  void initState() {
    _databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  // Widget chatMessageList() {}
  bool isImage = true;

  sendMessage() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": _messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      _databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);

      setState(() {
        _messageController.text = "";
      });
    }
  }

  _buildMessage(String message, bool isMe) {
    final Container msg = Container(
        child: isMe
            ? Align(
                alignment: Alignment(1, 0),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: Sizes.dimen_4.w,
                      left: Sizes.dimen_60.w,
                      top: Sizes.dimen_1.h,
                      bottom: Sizes.dimen_1.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Container(
                      color: Colors.blue,
                      // margin: EdgeInsets.only(left: 10.0),
                      child: Stack(
                        children: [
                          !isImage
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    right: Sizes.dimen_12.w,
                                    left: Sizes.dimen_12.w,
                                    top: Sizes.dimen_4.h,
                                    bottom: Sizes.dimen_6.h,
                                  ),
                                  child: Text(message),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    right: Sizes.dimen_12.w,
                                    left: Sizes.dimen_12.w,
                                    top: Sizes.dimen_4.h,
                                    bottom: Sizes.dimen_6.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        // child: Image.asset(
                                        //   imageAddress,
                                        //   height: 130,
                                        //   width: 130,
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      SizedBox(
                                        height: Sizes.dimen_1.h,
                                      ),
                                      Text(
                                        message,
                                      ),
                                    ],
                                  ),
                                ),
                          Positioned(
                            bottom: Sizes.dimen_1.h,
                            right: Sizes.dimen_6.w,
                            child: Text(
                              // time,
                              "3.0",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Align(
                alignment: Alignment(-1, 0),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: Sizes.dimen_60.w,
                      left: Sizes.dimen_4.w,
                      top: Sizes.dimen_1.h,
                      bottom: Sizes.dimen_1.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Container(
                      color: Colors.orange,
                      // margin: EdgeInsets.only(left: 10.0),
                      child: Stack(
                        children: [
                          !isImage
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    right: Sizes.dimen_12.w,
                                    left: Sizes.dimen_12.w,
                                    top: Sizes.dimen_4.h,
                                    bottom: Sizes.dimen_6.h,
                                  ),
                                  child: Text(message),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    right: Sizes.dimen_12.w,
                                    left: Sizes.dimen_12.w,
                                    top: Sizes.dimen_4.h,
                                    bottom: Sizes.dimen_6.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        // child: Image.asset(
                                        //   imageAddress,
                                        //   height: 130,
                                        //   width: 130,
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      SizedBox(
                                        height: Sizes.dimen_1.h,
                                      ),
                                      Text(
                                        message,
                                      ),
                                    ],
                                  ),
                                ),
                          Positioned(
                            bottom: Sizes.dimen_1.h,
                            right: Sizes.dimen_8.w,
                            child: Text(
                              // time,
                              "3.0",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
    if (isMe) {
      return msg;
    }

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     msg,
    //     IconButton(
    //       icon: Icon(Icons.favorite_border),
    //       color: Theme.of(context).primaryColor,
    //       iconSize: Sizes.dimen_28.w,
    //       onPressed: () {
    //         print('favourite button pressed');
    //       },
    //       // icon: message.isLiked
    //       //     ? Icon(
    //       //         Icons.favorite,
    //       //       )
    //       //     : Icon(Icons.favorite_border),
    //       // color:
    //       //     message.isLiked ? Theme.of(context).primaryColor : Colors.black,
    //       // iconSize: 30.0,
    //       // onPressed: () {
    //       //   print('favourite button pressed');
    //       // },
    //     )
    //   ],
    // );
    return msg;
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      margin: EdgeInsets.all(Sizes.dimen_12.w),
      height: Sizes.dimen_20.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[300],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add),
            color: Theme.of(context).primaryColor,
            iconSize: Sizes.dimen_28.w,
            onPressed: () {
              print('add media button pressed');
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              // onChanged: (value) {}, //message = value
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            iconSize: Sizes.dimen_32.w,
            onPressed: () {
              sendMessage();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.chattingWith, //TODO
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
                  "Clear Chat",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .apply(color: AppColor.white),
                ),
                value: SearchScreen(),
              ),
              PopupMenuItem(
                  child: Text(
                    "Block",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .apply(color: AppColor.white),
                  ),
                  value: ""), //todo
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6c757d), //bgcolor
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: StreamBuilder(
                    stream: chatMessageStream,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              // reverse: true,
                              padding: EdgeInsets.only(top: Sizes.dimen_2.h),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildMessage(
                                    snapshot.data.docs[index].data()["message"],
                                    snapshot.data.docs[index]
                                            .data()["sendBy"] ==
                                        Constants.myName);
                              },
                            )
                          : Container();
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
