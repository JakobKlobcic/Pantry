import 'package:flutter/material.dart';


class BYUTheme {
  static ThemeData get byuTheme { //1
    return ThemeData( //2
      //add app bar and menu
        primaryColor: Color(0xff7ED957),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat', //3
        buttonTheme: ButtonThemeData( // 4
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Color(0xff7ED957),
          textTheme: ButtonTextTheme.primary,
        )
    );
  }
}