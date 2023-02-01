import 'package:flutter/material.dart';
import 'package:tungalahari/language_String.dart';
import 'package:tungalahari/model/album.dart';
import 'package:tungalahari/model/songs.dart';
import 'package:tungalahari/song.dart';

class AlbumPage extends StatelessWidget {
  final List<Songs>? totalSongs;
  final Album album;
  final String? language;

  const AlbumPage({
    Key? key,
    this.totalSongs,
    required this.album,
    this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                expandedHeight: 250,
                album: album,
                language: language,
              ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${index + 1}",
                          ),
                        ],
                      ),
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: LanguageString(
                          language: language!,
                          englishText: totalSongs![index].title!,
                          tamilText: totalSongs![index].titleTam,
                          devanagariText: totalSongs![index].titleDev,
                          kannadaText: totalSongs![index].titleKan,
                          teluguText: totalSongs![index].titleTel,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: LanguageString(
                          language: language!,
                          englishText: totalSongs![index].writer!,
                          tamilText: totalSongs![index].writerTam,
                          devanagariText: totalSongs![index].titleDev,
                          kannadaText: totalSongs![index].titleKan,
                          teluguText: totalSongs![index].titleTel,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      trailing: Text(
                        "${totalSongs![index].duration}",
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Song(
                              name: totalSongs![index].title,
                              duration: totalSongs![index].duration,
                              singerName: totalSongs![index].writer,
                              subtitle: totalSongs![index].writer,
                              url: totalSongs![index].url,
                              songLayers: totalSongs![index].lyrics,
                              albumImage: album.id,
                              vocals: album.vocals,
                              titleTel: totalSongs![index].titleTel,
                              titleKan: totalSongs![index].titleKan,
                              titleDev: totalSongs![index].titleDev,
                              titleTam: totalSongs![index].titleTam,
                              writerKan: totalSongs![index].writerKan,
                              writerTel: totalSongs![index].writerTel,
                              writerDev: totalSongs![index].writerDev,
                              writerTam: totalSongs![index].writerTam,
                              lyricsIast: totalSongs![index].lyricsIast,
                              lyricsKan: totalSongs![index].lyricsKan,
                              lyricsTam: totalSongs![index].lyricsTam,
                              lyricsTel: totalSongs![index].lyricsTel,
                              language: language,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: totalSongs!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Album album;
  final String? language;

  MySliverAppBar({
    required this.expandedHeight,
    required this.album,
    this.language,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/bg_floral.png',
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/${album.id}.png',
                width: 200,
                height: 200,
              ),
            ),
            LanguageString(
              language: language!,
              englishText: album.title!,
              tamilText: album.titleTel,
              devanagariText: album.titleDev,
              kannadaText: album.titleKan,
              teluguText: album.titleTel,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 8, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${album.title}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
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
