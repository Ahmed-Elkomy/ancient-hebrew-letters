import 'package:ancient_hebrew_letters/cons/colors.dart';
import 'package:ancient_hebrew_letters/cons/icons_size.dart';
import 'package:ancient_hebrew_letters/cons/letters_data.dart';
import 'package:ancient_hebrew_letters/screens/letter_home_view.dart';
import 'package:flutter/material.dart';

class LetterWidget extends StatefulWidget {
  final int letterIndex;
  final bool empty;
  LetterWidget({this.letterIndex, this.empty = false});
  @override
  _LetterWidgetState createState() => _LetterWidgetState();
}

class _LetterWidgetState extends State<LetterWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.empty
        ? Container(
            width: kLETTER_CONTAINER_WIDTH,
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0))
        : GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LetterHomeView(
                    letterIndex: widget.letterIndex,
                  ),
                ),
              );
            },
            child: Container(
              width: kLETTER_CONTAINER_WIDTH,
              // height: kLETTER_CONTAINER_Hight,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Column(
                children: [
                  Container(
                      height: kLETTER_SIZE,
                      width: kLETTER_SIZE,
                      child: Image.asset(
                          'assets/${kLETTERS_DATA_MAP[widget.letterIndex][kIMAGE]}')),
                  SizedBox(height: 8),
                  Text(
                    kLETTERS_DATA_MAP[widget.letterIndex][kNAME].toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        color: kLETTER_COLOR_GRAY,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    kLETTERS_DATA_MAP[widget.letterIndex][kCODE],
                    style: TextStyle(
                        fontSize: 14,
                        color: kLETTER_COLOR_GRAY,
                        fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 8),
                ],
              ),
            ),
          );
  }
}
