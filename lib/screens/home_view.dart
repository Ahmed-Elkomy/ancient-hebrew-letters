import 'dart:io' show Platform;

import 'package:ancient_hebrew_letters/widgets/letter_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static final id = "HomeView";
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    //double width=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/${Platform.isMacOS ? 'aleph-ios.gif' : 'aleph-android.gif'}"),
                      fit: BoxFit.cover))),
          Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.black,
            ),
          ),
          SafeArea(
            child: Container(
              child: Container(
                padding:
                    EdgeInsets.only(top: height*.01,  right: 5, left: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getLetterRows(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getLetters(int startIndex, int endIndex) {
    List<Widget> widgets = List();

    for (int i = endIndex - 1; i >= startIndex; i--) {
      widgets.add(LetterWidget(
        letterIndex: i,
      ));
    }
    return widgets;
  }

  List<Widget> getLetterRows() {
    List<Row> rows = List();
    for (int i = 0; i < 5; i++) {
      rows.add(Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: getLetters(i * 4, (i * 4 + 4)),
      ));
    }
    rows.add(Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LetterWidget(
          empty: true,
        ),
        LetterWidget(letterIndex: 20),
        LetterWidget(letterIndex: 21),
        LetterWidget(
          empty: true,
        ),
      ],
    ));
    return rows;
  }
}
