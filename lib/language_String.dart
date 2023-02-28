import 'dart:math';

import 'package:Tungalahari/utils.dart';
import 'package:flutter/material.dart';

class LanguageString extends StatelessWidget {
  final String language;
  final String englishText;
  final String? tamilText;
  final String? devanagariText;
  final String? kannadaText;
  final String? teluguText;
  final String? gujaratiText;
  final String? malayalamText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLine;

  const LanguageString({
    Key? key,
    required this.language,
    required this.englishText,
    this.tamilText,
    this.devanagariText,
    this.kannadaText,
    this.teluguText,
    this.gujaratiText,
    this.malayalamText,
    this.style,
    this.textAlign, this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Utils.chooseLanguage(
        language,
        englishText: englishText,
        tamilText: tamilText,
        devanagariText: devanagariText,
        kannadaText: kannadaText,
        teluguText: teluguText,
        gujaratiText: gujaratiText,
        malayalamText: malayalamText,
      ),
      style: style,
      textAlign: textAlign,
      maxLines:maxLine,);
  }
}
