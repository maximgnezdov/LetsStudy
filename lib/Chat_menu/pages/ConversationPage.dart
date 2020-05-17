import 'package:flutter/material.dart';
import 'package:flutterapp/Chat_menu/widgets/ChatAppBar.dart';
import 'package:flutterapp/Chat_menu/widgets/ChatListWidget.dart';
import 'package:flutterapp/Chat_menu/config/Palette.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
  const ConversationPage();
}

class _ConversationPageState extends State<ConversationPage> {

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(flex: 3, child: ChatAppBar()), // Custom app bar for chat screen
      Expanded(
          flex: 12,
          child: Container(
            color: Palette.chatBackgroundColor,
            child: ChatListWidget(),
          ))
    ]);
  }
}