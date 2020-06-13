import 'package:letsstudy/helper/authenticate.dart';
import 'package:letsstudy/helper/constants.dart';
import 'package:letsstudy/helper/helperfunctions.dart';
import 'package:letsstudy/helper/theme.dart';
import 'package:letsstudy/services/auth.dart';
import 'package:letsstudy/services/database.dart';
import 'package:letsstudy/views/chat.dart';
import 'package:letsstudy/views/search.dart';
import 'package:flutter/material.dart';

class jackShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = new LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        stops: [
          0.8,
          1
        ],
        colors: [
          CustomTheme.selfMessageBackgroundColor,
          CustomTheme.gradientColor.withOpacity(0.6)
        ]);

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()
      ..shader = gradient.createShader(colorBounds);

    var path = Path();
    path.lineTo(0, size.height * 0.145498);
    path.quadraticBezierTo(size.width * 0.0335593, size.height * 0.9999999,
        size.width * 0.2309322, size.height * 0.958895);
    path.quadraticBezierTo(size.width * 0.7796610, size.height * 0.7052208,
        size.width, size.height * 0.963190);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 100;

  const ChatAppBar();

  @override
  Widget build(BuildContext context) {
    // Text style for everything else

    // double width = MediaQuery.of(context).size.width; // calculate the screen width
    return Material(
        child: Container(
          color: CustomTheme.chatBackgroundColor,
          child: CustomPaint(
            painter: jackShape(),
            child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 30),
                child: Row(children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                          child:  Image
                                    .asset(
                                  "assets/images/logoLetsStudyText.png",
                                  fit: BoxFit.contain,
                                )

                              )),
                  Expanded(
                    //we're dividing the appbar into 7 : 3 ratio. 7 is for content and 3 is for the display picture.
                      flex: 1,
                      child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.exit_to_app,
                                                    color: CustomTheme.primaryColor,
                                                  ),
                                                  onPressed: () {
                                                    AuthService().signOut();
                                                    Navigator.pushReplacement(context,
                                                        MaterialPageRoute(builder: (context) => Authenticate()));
                                                  }))),
                                    ],
                                  )),
                              //second row containing the buttons for media
                            ],
                          ))),
                  //This is the display picture
                ])),
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}