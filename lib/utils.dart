class Utils {
  static String chooseLanguage(String selectedLanguage,
      {required String englishText,
      String? tamilText,
      String? devanagariText,
      String? kannadaText,
      String? teluguText,
      String? gujaratiText,
      String? malayalamText}) {
    switch (selectedLanguage) {
      case "Devanagari":
        return devanagariText ?? englishText;
      case "Kannada":
        return kannadaText ?? englishText;
      case "Tamil":
        return tamilText ?? englishText;
      case "Telugu":
        return teluguText ?? englishText;
      case "Gujarati":
        return gujaratiText ?? englishText;
      case "Malayalam":
        return malayalamText ?? englishText;
      default:
        return englishText;
    }
  }
}
