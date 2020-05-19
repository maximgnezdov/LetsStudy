import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/Chat_menu/providers/AuthenticationProvider.dart';
import 'package:flutterapp/Chat_menu/providers/BaseProviders.dart';

class AuthenticationRepository {
  BaseAuthenticationProvider authenticationProvider = AuthenticationProvider();

  Future<FirebaseUser> signInWithGoogle() =>
      authenticationProvider.signInWithGoogle();

  Future<void> signOutUser() => authenticationProvider.signOutUser();

  Future<FirebaseUser> getCurrentUser() =>
      authenticationProvider.getCurrentUser();

  Future<bool> isLoggedIn() => authenticationProvider.isLoggedIn();
}