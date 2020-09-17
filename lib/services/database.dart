import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserWithUsername(String username) async {
    return await Firestore.instance
        .collection('users')
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserInfo(String userEmail) async {
    try {
      return await Firestore.instance
          .collection('users')
          .where("email", isEqualTo: userEmail)
          .getDocuments();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection('users')
        .where('name', isEqualTo: searchField)
        .getDocuments();
  }

  makeRequestToUser(String chatRoomId, chatRoomMap) {
    try {
      Firestore.instance
          .collection('requests')
          .document(chatRoomId)
          .setData(chatRoomMap);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  uploadUserInfo(userMap) {
    try {
      Firestore.instance.collection('users').add(userMap);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  addConversationMessages(String chatRoomId, messageMap) {
    try {
      Firestore.instance
          .collection("requests")
          .document(chatRoomId)
          .collection("chats")
          .add(messageMap);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  getConversationMessages(String chatRoomId) async {
    return Firestore.instance
        .collection("requests")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  getChatRooms(String userName) async {
    return Firestore.instance
        .collection("requests")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
