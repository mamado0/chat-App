import 'package:chatmes_app/chats/messages.dart';
import 'package:chatmes_app/chats/new_messages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((msg) => null);
    FirebaseMessaging.onMessage.listen((msg) {});
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          FlatButton.icon(
              textColor: const Color(0xFFFF9000),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.person),
              label: const Text('Logout')),
        ],
      ),
      body: Container(
          child: Column(children: const [
        Expanded(child: Messages()),
        NewMessage(),
      ])),
    );
  }
}
