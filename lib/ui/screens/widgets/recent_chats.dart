import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/helper/constants.dart';
import 'package:hey_fellas/ui/screens/chats/chat_screen.dart';

class RecentChats extends StatefulWidget {
  final Stream<QuerySnapshot> chatRooms;

  RecentChats({this.chatRooms});
  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: StreamBuilder(
            stream: widget.chatRooms,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatScreen(
                                    chatRoomId: snapshot.data.documents[index]
                                        .data["chatroomid"],
                                    chattingWith: snapshot.data.documents[index]
                                        .data['chatroomid']
                                        .toString()
                                        .replaceAll("_", "")
                                        .replaceAll(Constants.myName, ""),
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0), //TODO
                            margin: EdgeInsets.only(
                                top: 5.0, bottom: 5.0, right: 10.0),
                            decoration: BoxDecoration(
                              // color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
                              color: Color(0xFFadb5bd),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 35.0,
                                      // backgroundImage: AssetImage(chat.sender.imageUrl),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.documents[index]
                                              .data['chatroomid']
                                              .toString()
                                              .replaceAll("_", "")
                                              .replaceAll(Constants.myName, ""),
                                          style: TextStyle(
                                            color: Colors.grey, //color chang
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            // chat.text,
                                            "message",
                                            style: TextStyle(
                                              color:
                                                  Colors.blueGrey, //color chang
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      // chat.time,
                                      "3.0",
                                      style: TextStyle(
                                        color: Colors.grey, //color chang
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    // chat.unread
                                    Container(
                                      width: 40.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'new',
                                        style: TextStyle(
                                          color: Colors.white, //color chang
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      // : Text(""), //SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container();
            },
          ),
        ),
      ),
    );
  }
}
