import 'package:chat_app_firebase/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        //return
        return user;
      }).toList();
    });
  }

  //send a message
  Future<void> sendMessage(String receiverID, message) async {
    //get current user
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //create a new messsage
    Message newMessage = Message(
        senderID: currentUserId,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //construct chat room ID for the two users(sorted to store uniquness)
    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String chatRoomID = ids.join('-');

    //add new message to db
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get a message
  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    //construct  a chat room  ID for two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('-');
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
