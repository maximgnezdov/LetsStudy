import 'package:flutter/material.dart';
import 'Chat_menu/config/Palette.dart';
import 'Chat_menu/pages/ConversationPageSlide.dart';
import 'Chat_menu/pages/RegisterPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/Chat_menu/pages/ConversationPageSlide.dart';
import 'package:flutterapp/Chat_menu/repositories/AuthenticationRepository.dart';
import 'package:flutterapp/Chat_menu/repositories/StorageRepository.dart';
import 'package:flutterapp/Chat_menu/repositories/UserDataRepository.dart';
import 'Chat_menu/blocs/authentication/Bloc.dart';

void main() {
  //create instances of the repositories to supply them to the app
  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(
          authenticationRepository: authRepository,
          userDataRepository: userDataRepository,
          storageRepository: storageRepository)
        ..dispatch(AppLaunched()),
      child: LetsStudy(),
    ),
  );
}

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
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UnAuthenticated) {
            return RegisterPage();
          } else if (state is ProfileUpdated) {
            return ConversationPageSlide();
          } else {
            return RegisterPage();
          }
        },
      ),
    );
  }
}