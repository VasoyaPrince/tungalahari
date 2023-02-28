import 'package:Tungalahari/album_page.dart';
import 'package:Tungalahari/language_String.dart';
import 'package:Tungalahari/model/album.dart';
import 'package:flutter/material.dart';

class AlbumItems extends StatelessWidget {
  final Album album;
  final String language;

  const AlbumItems({
    Key? key,
    required this.album,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () => _navigateToNextScreen(context),
        child: Card(
          color: Colors.white,
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 170,
                child: Image.asset(
                  'assets/images/${album.id}.png',
                  fit: BoxFit.fill,
                  // height: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: LanguageString(
                        language: language,
                        englishText: album.title!,
                        tamilText: album.titleTam,
                        devanagariText: album.titleDev,
                        gujaratiText: album.titleGuj,
                        kannadaText: album.titleKan,
                        malayalamText: album.titleMal,
                        teluguText: album.titleTel,
                        style: const TextStyle(color: Colors.black, fontSize: 12),
                        maxLine: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${album.totalSongs?.length} ${'Songs'}",
                          style: const TextStyle(
                              color: Colors.black38, fontSize: 10)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            AlbumPage(totalSongs: album.totalSongs, album: album, language:language),
      ),
    );
  }
}
