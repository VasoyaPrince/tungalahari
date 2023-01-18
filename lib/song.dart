import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Song extends StatefulWidget {
  const Song({Key? key}) : super(key: key);

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
        isPlaying = event == PlayerState.PLAYING;
      });
    });

    player.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    player.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  Future setAudio() async {
    player.setReleaseMode(ReleaseMode.LOOP);
    String url =
        "https://djmaza.live/siteuploads/files/sfd18/8857/See%20You%20Again_128-(DJMaza).mp3";
    await player.play(url);
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
                          'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
                          fit: BoxFit.fill,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Song Name'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              Text(
                                'Subtitle'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Singer Name'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 320,
                                child: ProgressBar(
                                  timeLabelTextStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  progress: Duration(
                                    seconds: position.inSeconds,
                                  ),
                                  buffered: Duration(milliseconds: 2000),
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
                                    final position = Duration(
                                        seconds: duration.inSeconds);
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
                                  child: Icon(
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
          body: Container()),
    );
  }
}
