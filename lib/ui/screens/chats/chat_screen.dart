import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/helper/constants.dart';
// import 'package:hey_fellas/models/message_model/message_model.dart';
// import 'package:hey_fellas/models/userdata/user_model.dart';
import 'package:hey_fellas/services/database.dart';

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
      margin: isMe
          ? EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
            ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Color(0xFFffd166) : Color(0xFFadf6b1),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "3.0",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }

    return Row(
      children: [
        msg,
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Theme.of(context).primaryColor,
          iconSize: 30.0,
          onPressed: () {
            print('favourite button pressed');
          },
          // icon: message.isLiked
          //     ? Icon(
          //         Icons.favorite,
          //       )
          //     : Icon(Icons.favorite_border),
          // color:
          //     message.isLiked ? Theme.of(context).primaryColor : Colors.black,
          // iconSize: 30.0,
          // onPressed: () {
          //   print('favourite button pressed');
          // },
        )
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.all(8.0),
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[300],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.tag_faces),
            color: Theme.of(context).primaryColor,
            iconSize: 30.0,
            onPressed: () {
              print('face button pressed');
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
            iconSize: 30.0,
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
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              print('menu button pressed');
            },
          )
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
                    stream: chatMessageStream,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              // reverse: true,
                              padding: EdgeInsets.only(top: 5.0),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildMessage(
                                    snapshot
                                        .data.documents[index].data["message"],
                                    snapshot.data.documents[index]
                                            .data["sendBy"] ==
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
