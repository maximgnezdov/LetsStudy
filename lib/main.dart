import 'package:flutter/material.dart';
import 'Chat_menu/pages/ConversationPageList.dart';
void main() => runApp(LetsStudy());

class LetsStudy extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: ConversationPageList(),
    );
  }
}