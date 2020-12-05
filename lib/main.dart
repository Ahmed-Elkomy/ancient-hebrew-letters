import 'package:ancient_hebrew_letters/screens/home_view.dart';
import 'package:ancient_hebrew_letters/screens/letter_home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ancient Hebrew-Letters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
      initialRoute: HomeView.id,
      routes: {
        HomeView.id: (context) => HomeView(),
        LetterHomeView.id: (context) => LetterHomeView()
      },
    );
  }
}
