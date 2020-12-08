import 'dart:io' show Platform;

import 'package:ancient_hebrew_letters/cons/colors.dart';
import 'package:ancient_hebrew_letters/cons/icons_size.dart';
import 'package:ancient_hebrew_letters/cons/letters_data.dart';
import 'package:flutter/material.dart';

class LetterDescription extends StatefulWidget {
  static final id = 'LetterDescription';
  final int letterIndex;
  LetterDescription({this.letterIndex});
  @override
  _LetterDescriptionState createState() => _LetterDescriptionState();
}

class _LetterDescriptionState extends State<LetterDescription> {
  final double spacing = 20.0;
  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: kLETTER_ICON_SIZE_LETTER_DESCRIPTION,
                        width: kLETTER_ICON_SIZE_LETTER_DESCRIPTION,
                        child: Image.asset(
                            'assets/${kLETTERS_DATA_MAP[widget.letterIndex][kIMAGE]}')),
                    SizedBox(
                      height: spacing,
                    ),
                    Text(
                      kLETTERS_DATA_MAP[widget.letterIndex][kNAME]
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 35,
                        color: kLETTER_COLOR_OFF_WHITE,
                      ),
                    ),
                    SizedBox(
                      height: spacing,
                    ),
                    Text(
                      'I stand as the first letter of the livig ones. \nI am known as th silent one, with no need to speak uness another is added to me. I open the way for all other letters to be known, though the chambers of love and intimacy within the realm of Heaven.',
                      style: TextStyle(
                          color: kLETTER_COLOR_OFF_WHITE, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: spacing,
                    ),
                    Text(
                      "I am the Ox, the burden bearer, the one who plows. I am the outward'pushing forward' energy that is the seed if the cosmos, the primal force of creation that existed befre any form could visualized.",
                      style: TextStyle(
                          color: kLETTER_COLOR_OFF_WHITE, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: spacing,
                    ),
                    Text(
                      'I plow fields so that nourishment can be planeted for growth and prosperity of those who eat from the fields I have plowed',
                      style: TextStyle(
                          color: kLETTER_COLOR_OFF_WHITE, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: spacing,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,),onPressed: (){
                Navigator.pop(context);
              },),
            ),
          )
        ],
      ),
    );
  }
}
