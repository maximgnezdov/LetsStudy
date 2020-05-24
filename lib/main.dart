import 'package:flutter/material.dart';
import 'Chat_menu/config/Palette.dart';
import 'Chat_menu/pages/ConversationPageSlide.dart';
import 'Chat_menu/pages/RegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(LetsStudy());

class LetsStudy extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primaryColor: Palette.primaryColor,
      ),
      //home: ConversationPageSlide(),
      home: RegisterPage(),
    );
  }
}