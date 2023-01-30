import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Song extends StatefulWidget {
  final String? name;
  final String? subtitle;
  final String? duration;
  final String? url;
  final String? singerName;
  final String? albumImage;
  final String? songLayers;

  const Song({
    Key? key,
    this.name,
    this.subtitle,
    this.duration,
    this.url,
    this.singerName,
    this.albumImage,
    this.songLayers,
  }) : super(key: key);

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    setAudio();

    player.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    player.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  Future setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    await player.play(UrlSource("${widget.url}"));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 260.0,
              floating: false,
              titleSpacing: 0.0,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                centerTitle: false,
                background: SizedBox(
                  height: 250.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        '${widget.albumImage}',
                        fit: BoxFit.fill,
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [Colors.black38, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.2, 0.6],
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              "${widget.name}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            Text(
                              "${widget.subtitle}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "${widget.singerName}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 320,
                              child: ProgressBar(
                                timeLabelTextStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                progress: Duration(
                                  seconds: position.inSeconds,
                                ),
                                buffered: const Duration(milliseconds: 2000),
                                total: Duration(
                                  seconds: duration.inSeconds,
                                ),
                                progressBarColor: Colors.red,
                                baseBarColor: Colors.white.withOpacity(0.24),
                                bufferedBarColor:
                                    Colors.white.withOpacity(0.24),
                                thumbColor: Colors.white,
                                barHeight: 3.0,
                                thumbRadius: 5.0,
                                onSeek: (duration) async {
                                  final position =
                                      Duration(seconds: duration.inSeconds);
                                  await player.seek(duration);
                                  await player.pause();
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (isPlaying) {
                                  await player.pause();
                                } else {
                                  await player.resume();
                                }
                              },
                              child: Icon(
                                isPlaying
                                    ? Icons.pause_circle_outlined
                                    : Icons.play_circle_outlined,
                                color: Colors.white,
                                size: 70,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: const Icon(
                                  Icons.arrow_circle_down_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Html(
            data: widget.songLayers,
            tagsList: Html.tags,
            style: {
              "body": Style(
                fontSize: const FontSize(18.0),
                fontWeight: FontWeight.bold,
              ),
            },
          ),
        ),
      ),
    );
  }
}
