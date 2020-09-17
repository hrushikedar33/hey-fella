// import 'package:flutter/material.dart';
// import 'package:hey_fellas/models/message_model/message_model.dart';
// import 'package:hey_fellas/ui/screens/chats/chat_screen.dart';

// class FavouriteContacts extends StatefulWidget {
//   @override
//   _FavouriteContactsState createState() => _FavouriteContactsState();
// }

// class _FavouriteContactsState extends State<FavouriteContacts> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.0),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Favourite Contact",
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.0,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.more_horiz,
//                   ),
//                   iconSize: 30.0,
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 120.0,
//             child: ListView.builder(
//               padding: EdgeInsets.only(left: 10.0),
//               scrollDirection: Axis.horizontal,
//               itemCount: favorites.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return ChatScreen(
//                             user: favorites[index],
//                           );
//                         },
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 35.0,
//                           backgroundImage:
//                               AssetImage(favorites[index].imageUrl),
//                         ),
//                         SizedBox(
//                           height: 6.0,
//                         ),
//                         Text(
//                           favorites[index].name,
//                           style: TextStyle(
//                             color: Colors.blueGrey,
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
