import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsstudy/helper/theme.dart';
import 'package:letsstudy/views/Settings.dart';
import 'package:letsstudy/views/profile.dart';
import 'package:letsstudy/views/support.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: CustomTheme.chatBackgroundColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                        top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/user_icon.png"),
                        fit: BoxFit.fill,
                      )
                    ),
                  ),
                  Text("Vova",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w300)),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Design",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300)),
                  SizedBox(
                    width: 12,
                  ),
                  Text("anna@gmail.com",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300)),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Progile",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
              ),
              ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings",
              style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w300)),
              onTap:() { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
              },
              ),
              ListTile(
              leading: Icon(Icons.question_answer),
              title: Text("Support",
              style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300)),
            onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportPage()),
            );
            },
          ),
        ],
      ),
    );
  }
}
