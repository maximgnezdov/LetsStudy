import 'package:flutter/material.dart';
import 'config/Palette.dart';
import 'pages/ConversationPageSlide.dart';
import 'pages/RegisterPage.dart';
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