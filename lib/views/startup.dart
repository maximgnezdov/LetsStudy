import 'package:flutter/cupertino.dart';
import 'package:letsstudy/helper/helperfunctions.dart';
import 'package:letsstudy/helper/theme.dart';
import 'package:letsstudy/helper/authenticate.dart';
import 'package:letsstudy/services/auth.dart';
import 'package:letsstudy/services/database.dart';
import 'package:letsstudy/views/signin.dart';
import 'package:letsstudy/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}


class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.5,
              1
            ],
            colors: [
              CustomTheme.alterBackground,
              CustomTheme.alterGradient,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 200,),
            Image.asset('assets/images/logoWithSLogan.png',),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  )
              ),
              height: 60,
              width: 100,
              child: Text(
                "Start",
                style:
                TextStyle(fontSize: 19, color: CustomTheme.selfMessageColor),
                textAlign: TextAlign.center,
              ),
            ),
            ),
          ],
        ),
      ),

    );
  }
}








