import 'package:chat_app_firebase/components/my_drawer.dart';
import 'package:chat_app_firebase/components/user_tile.dart';
import 'package:chat_app_firebase/pages/chat_page.dart';
import 'package:chat_app_firebase/services/auth/auth_service.dart';
import 'package:chat_app_firebase/services/chat/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          const Text(
            "Your Contacts",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          Expanded(child: _buildUserList()),
        ],
      ),
    );
  }

  //build a list of user except current user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return Text("Some Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }

          //return listview
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData['email'],
                        receiverID: userData['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
