import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserWithUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: username)
        .get();
  }

  getAllWithUsername() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }

  getUserInfo(String userEmail) async {
    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: userEmail)
          .get();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: searchField)
        .get();
  }

  makeRequestToUser(String chatRoomId, chatRoomMap) {
    try {
      FirebaseFirestore.instance
          .collection('requests')
          .doc(chatRoomId)
          .set(chatRoomMap);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  uploadUserInfo(userMap) {
    try {
      FirebaseFirestore.instance.collection('users').add(userMap);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  addConversationMessages(String chatRoomId, messageMap) {
    try {
      FirebaseFirestore.instance
          .collection("requests")
          .doc(chatRoomId)
          .collection("chats")
          .add(messageMap);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("requests")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  getChatRooms(String userName) async {
    return FirebaseFirestore.instance
        .collection("requests")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
