import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsstudy/helper/theme.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
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
            Text("Hi there, if you would like to leave a message or report a bug please contact us at letsstudy@gmail.com",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300)),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
                width: 120,
                child: Text(
                  "Go back:)",
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

    /*
      Scaffold(
      backgroundColor: CustomTheme.chatBackgroundColor,
      appBar: AppBar(
        backgroundColor: CustomTheme.chatBackgroundColor,
        title: Text("Support"),
      ),
      body: Container(
        child:
        Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back:)'),
            ),
          ],
        ),
      ),
    );
  }

       */
  }
}
