import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_fellas/helper/constants.dart';
import 'package:hey_fellas/ui/screens/chats/chat_screen.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';
import 'package:hey_fellas/ui/theme/themecolor.dart';

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
          color: Theme.of(context).unselectedWidgetColor,
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
                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatScreen(
                                    chatRoomId: snapshot.data.docs[index]
                                        .data()["chatroomid"],
                                    chattingWith: snapshot.data.docs[index]
                                        .data()['chatroomid']
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
                                horizontal: Sizes.dimen_20.w,
                                vertical: Sizes.dimen_4.h),
                            margin: EdgeInsets.only(
                                top: Sizes.dimen_1.h,
                                bottom: Sizes.dimen_1.h,
                                right: Sizes.dimen_6.w,
                                left: Sizes.dimen_6.w),
                            decoration: BoxDecoration(
                              // color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,

                              color: Colors.lightBlueAccent, //todo
                              // borderRadius: BorderRadius.only(
                              //   topRight: Radius.circular(20.0),
                              //   bottomRight: Radius.circular(20.0),
                              // ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25.0,
                                      // backgroundImage: AssetImage(chat.sender.imageUrl),
                                    ),
                                    SizedBox(width: Sizes.dimen_12.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.docs[index]
                                              .data()['chatroomid']
                                              .toString()
                                              .replaceAll("_", "")
                                              .replaceAll(Constants.myName, ""),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .apply(
                                                  color: Colors.white,
                                                  fontWeightDelta: 2),
                                        ),
                                        SizedBox(
                                          height: Sizes.dimen_2.h,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            // chat.text,
                                            "message",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .apply(color: AppColor.black),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .apply(
                                              color: AppColor.black,
                                              fontWeightDelta: 2),
                                    ),
                                    SizedBox(
                                      height: Sizes.dimen_2.h,
                                    ),
                                    // chat.unread
                                    Container(
                                      width: Sizes.dimen_40.w,
                                      height: Sizes.dimen_8.h,
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
                                          fontSize: Sizes.dimen_12.sp,
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
