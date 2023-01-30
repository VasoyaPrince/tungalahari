import 'package:flutter/material.dart';
import 'package:tungalahari/model/songs.dart';
import 'package:tungalahari/song.dart';

class AlbumPage extends StatelessWidget {
  final List<Songs>? totalSongs;
  final String? albumImage;

  const AlbumPage({Key? key, this.totalSongs, this.albumImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              titleSpacing: 0.0,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: Image.network(
                  '$albumImage',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: totalSongs!.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 5,
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$index",
                    ),
                  ],
                ),
                title: Text("${totalSongs![index].title}"),
                subtitle: Text("${totalSongs![index].writer}"),
                trailing: Text("${totalSongs![index].duration}"),
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
                          albumImage: albumImage),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
