import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        loggedInUser = user;
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _fireStore.collection('messages').add(
                          {'sender': loggedInUser.email, 'text': messageText});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        if (snapshot.hasData) {
          final messages = snapshot.data.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];

            final currentUser = loggedInUser.email;

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
              child: ListView(
                  reverse: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  children: messageBubbles));
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({this.isMe, this.sender, this.text});
  final bool isMe;
  final String text;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                '$sender',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Material(
                  elevation: 5.0,
                  borderRadius: isMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                  color: isMe ? Colors.lightBlueAccent : Colors.white,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    child: Text(
                      '$text',
                      style: TextStyle(
                          fontSize: 15,
                          color: isMe ? Colors.white : Colors.black54),
                    ),
                  ))
            ]));
  }
}
