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
    this.style, this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(chooseLanguage(language), style: style);
  }

  String chooseLanguage(String selectedLanguage) {
    switch (selectedLanguage) {
      case "Devanagari":
        return "$devanagariText";
      case "Kannada":
        return "$kannadaText";
      case "Tamil":
        return "$tamilText";
      case "Telugu":
        return "$teluguText";
      case "Gujarati":
        return "$gujaratiText";
      case "Malayalam":
        return "$malayalamText";
      default:
        return englishText;
    }
  }
}
