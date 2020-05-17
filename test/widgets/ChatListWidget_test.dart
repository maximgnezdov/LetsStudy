import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/Chat_menu/widgets/ChatListWidget.dart';

void main(){
  MaterialApp app = MaterialApp(
    home: Scaffold(
        body:  ChatListWidget()
    ),
  );
  testWidgets('ChatListWidget UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //await tester.pumpWidget(LetsStudy());
    await tester.pumpWidget(app);
    expect(find.byType(ListView),findsOneWidget);

  });
}