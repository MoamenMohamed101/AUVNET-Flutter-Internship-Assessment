import 'package:flutter/material.dart';
import 'package:nawel/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontFamily: FontConstants.dmSansFamily,
  );
}

TextStyle getRegularTextStyle({
  double fontSize = FontSizeManager.s12,
  required Color color,
}) =>
    _getTextStyle(
      fontSize,
      FontWeightManager.regular,
      color,
    );

TextStyle getMediumTextStyle({
  double fontSize = FontSizeManager.s12,
  required Color color,
}) =>
    _getTextStyle(
      fontSize,
      FontWeight.bold,
      color,
    );