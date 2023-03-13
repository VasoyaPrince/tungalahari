import 'package:Tungalahari/language_String.dart';
import 'package:Tungalahari/model/songs.dart';
import 'package:Tungalahari/player.dart';
import 'package:Tungalahari/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'clip_below_height.dart';

class Song extends StatelessWidget {
  final Songs songs;
  final String? singerName;
  final String? albumImage;
  final String? vocals;
  final String? language;

  const Song({
    Key? key,
    required this.songs,
    this.singerName,
    this.albumImage,
    this.vocals,
    this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: MySliverAppBar(
                  expandedHeight: 330,
                  albumImage: '$albumImage',
                  song: songs,
                  language: language,
                  vocals: vocals,
                ),
              ),
            ),
          ],
          body: Builder(
            builder: (context) {
              return CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Html(
                          data: Utils.chooseLanguage(
                            language!,
                            englishText: songs.lyricsIast!,
                            tamilText: songs.lyricsTam,
                            devanagariText: songs.lyrics,
                            kannadaText: songs.lyricsKan,
                            teluguText: songs.lyricsTel,
                          ),
                          shrinkWrap: true,
                          style: {
                            "body": Style(
                                fontSize: const FontSize(18.0),
                                display: Display.BLOCK),
                            "p": Style(
                              margin: EdgeInsets.zero,
                            ),
                          },
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String albumImage;
  final Songs song;
  final String? vocals;
  final String? language;

  MySliverAppBar({
    required this.song,
    required this.expandedHeight,
    required this.albumImage,
    this.vocals,
    this.language,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double progress = shrinkOffset < kToolbarHeight
        ? shrinkOffset / maxExtent
        : (shrinkOffset + kToolbarHeight) / maxExtent;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          'assets/images/$albumImage.png',
          fit: BoxFit.cover,
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: progress,
          child: Container(
            color: Colors.red,
            padding: const EdgeInsets.fromLTRB(15, 8, 8, 15),
            alignment: Alignment.bottomLeft,
            child: LanguageString(
              language: language!,
              englishText: '${song.title}',
              tamilText: song.titleTam,
              devanagariText: song.titleDev,
              kannadaText: song.titleKan,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
              maxLine: 1,
            ),
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: 1 - progress,
          child: ClipBelowHeight(
            clipHeight: maxExtent,
            opacityFactor: 1 - progress,
            child: Player(
              songs: song,
              language: language,
              vocals: vocals,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
