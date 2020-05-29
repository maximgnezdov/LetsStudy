import 'package:flutter/material.dart';
import 'package:letsstudy/widgets/widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: userNameTextEditingController,
                  style: simpleTextStyle(),
                  decoration: textFieldDecoration("username"),
                ),
                TextField(
                  controller: emailTextEditingController,
                  style: simpleTextStyle(),
                  decoration: textFieldDecoration("email"),
                ),
                TextField(
                  controller: passwordTextEditingController,
                  style: simpleTextStyle(),
                  decoration: textFieldDecoration("password"),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text("Forgot Password?", style: simpleTextStyle(),),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A75BC)
                          ]
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Sign Up", style: mediumTextStyle(),),
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Sign Up with Google", style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17
                  ),),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account? ", style: mediumTextStyle(),),
                    Text("SignIn now", style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline
                    ),)
                  ],
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
