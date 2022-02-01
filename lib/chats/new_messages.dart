import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _newController = TextEditingController();
  var _enteredMaeeage = '';
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'Text': _enteredMaeeage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData['userName'],
      'userImage': userData['image_Url'],
    });
    _newController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _newController,
            decoration: const InputDecoration(labelText: 'Send a Message....'),
            onChanged: (value) {
              setState(() {
                _enteredMaeeage = value;
              });
            },
          )),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.send),
            onPressed: _enteredMaeeage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
