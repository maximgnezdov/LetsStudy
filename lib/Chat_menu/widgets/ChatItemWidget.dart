import 'package:flutter/material.dart';
import 'package:flutterapp/Chat_menu/config/Palette.dart';
import 'package:flutterapp/Chat_menu/config/Style.dart';
import 'package:intl/intl.dart';

class ChatItemWidget extends StatelessWidget{
  final int index;

 const ChatItemWidget(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (index % 2 == 0) {
      return Container(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    'This is a sent message',
                    style: TextStyle(color: Palette.selfMessageColor),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Palette.selfMessageBackgroundColor, Palette.gradientColor.withOpacity(0.6)],
                        stops: [0.55, 1],
                      ),
                      borderRadius: BorderRadius.circular(50.0)),
                  margin: EdgeInsets.only(right: 10.0),
                )
              ],
              mainAxisAlignment:
              MainAxisAlignment.end, // aligns the chatitem to right end
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
                      style: Styles.date,
                    ),
                    margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                  )])
          ]));
    } else {
      // This is a received message
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    'This is a received message',
                    style: TextStyle(color: Palette.otherMessageColor),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Palette.otherMessageBackgroundColor,
                      borderRadius: BorderRadius.circular(50.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),
            Container(
              child: Text(
                DateFormat('dd MMM kk:mm').format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
                style: Styles.date,
              ),
              margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }  }

}