import 'package:letsstudy/helper/helperfunctions.dart';
import 'package:letsstudy/helper/theme.dart';
import 'package:letsstudy/services/auth.dart';
import 'package:letsstudy/services/database.dart';
import 'package:letsstudy/views/chatrooms.dart';
import 'package:letsstudy/views/forgot_password.dart';
import 'package:letsstudy/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
        // appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
            : Container(
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
                 /*image: DecorationImage(
                   image: AssetImage(
                       'assets/images/app background.png'),
                   fit: BoxFit.fitWidth,
                   alignment: Alignment.topCenter,

                 ),*/
                child: Column(
                  children: [
                    Spacer(),
                    Form(
                      key: formKey,
                        child: Column(
                          children: [
                              TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Please Enter Correct Email";
                                },
                                controller: emailEditingController,
                                style: simpleTextStyle(),
                                decoration: textFieldInputDecoration("email"),
                              ),
                            TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Enter Password 6+ characters";
                              },
                              style: simpleTextStyle(),
                              controller: passwordEditingController,
                              decoration: textFieldInputDecoration("password"),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 16,
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Forgot Password?",
                                style: simpleTextStyle(),
                              )),
                        )
                      ],
                    ),*/
                    SizedBox(
                      height: 36,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Sign In",
                          style:
                          TextStyle(fontSize: 19, color: CustomTheme.alterGradient.withOpacity(0.9)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView();
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
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Sign up",
                        style:
                            TextStyle(fontSize: 19, color: CustomTheme.selfMessageColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
      ),
                    SizedBox(
                      height: 16,
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          style: simpleTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            "Register now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),*/
                    SizedBox(
                      height: 200,
                    )
                  ],
                ),
              ),
    );
  }
}
