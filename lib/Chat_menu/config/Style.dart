import 'package:flutter/material.dart';

import 'Palette.dart';

class Styles{
  static TextStyle textHeading = TextStyle(
      color: Palette.primaryTextColor,
      fontSize: 20,
      fontFamily: 'Montserrat'
  ); // Text style for the name
  static TextStyle subHeading = TextStyle(
      color: Palette.primaryTextColor,
      fontSize: 14,
      fontFamily: 'Montserrat'
  );
  static TextStyle text = TextStyle(
      color: Palette.secondaryTextColor,
      fontFamily: 'OpenSans'
  );
  static TextStyle subText = TextStyle(
      color: Palette.primaryTextColor,
      fontFamily: 'OpenSans'
  );
  static TextStyle date = TextStyle(
      color: Palette.greyColor,
      fontSize: 12.0,
      fontStyle: FontStyle.normal,
      fontFamily: 'OpenSans'
  );
}