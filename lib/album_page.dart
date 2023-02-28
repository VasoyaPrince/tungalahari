import 'package:Tungalahari/language_String.dart';
import 'package:Tungalahari/model/album.dart';
import 'package:Tungalahari/model/songs.dart';
import 'package:Tungalahari/song.dart';
import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  final List<Songs>? totalSongs;
  final Album album;
  final String language;

  const AlbumPage({
    Key? key,
    this.totalSongs,
    required this.album,
    required this.language,
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
                delegate: MySliverAppBar(
                  expandedHeight: 250,
                  album: album,
                  language: language,
                ),
                pinned: true,
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
                                language: language,
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
                                language: language,
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
                                    songs: totalSongs![index],
                                    albumImage: album.id,
                                    vocals: album.vocals,
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
            const SizedBox(height: 5)
          ],
        ),
        Opacity(
          opacity: shrinkOffset < kToolbarHeight
              ? shrinkOffset / expandedHeight
              : (shrinkOffset + kToolbarHeight) / expandedHeight,
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
