import 'package:flutter/material.dart';

final appTheme = ThemeData(
    primaryColor: Color(0xFF5DB075),
    accentColor: Color(0xFF464646),
    backgroundColor: Color(0xFFFFFFFF),
    textTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 25.0,
            color: Colors.black87,
        ),
        headline2: TextStyle( // Title Text
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            fontSize: 22.0,
            color: Colors.black87,
        ),
        headline3: TextStyle( // Button Text
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            color: Colors.black87,
        ),
        bodyText1: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            color: Colors.black87,
        ),
        bodyText2: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            color: Color(0xFF5DB075),
        )
    )
);