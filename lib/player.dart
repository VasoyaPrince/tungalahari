import 'dart:async';
import 'dart:developer';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'service/download_service.dart';
import 'model/songs.dart';
import 'language_String.dart';

class Player extends StatefulWidget {
  final Songs songs;
  final String? language;
  final String? vocals;

  const Player({Key? key, required this.songs, this.language, this.vocals})
      : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late TaskInfo _taskInfo;
  bool _isLoading = true;
  StreamSubscription? _downloadStream;
  bool _isReady = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
      _prepare();
    });
    _taskInfo = TaskInfo(link: widget.songs.url);
  }

  Future<void> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();
    if (tasks != null) {
      for (var task in tasks) {
        if (_taskInfo.link == task.url) {
          _taskInfo.taskId = task.taskId;
          _taskInfo.status = task.status;
          _taskInfo.progress = task.progress;
        }
      }
      setState(() {
        _isLoading = false;
      });
    }
    _downloadStream =
        DownloadService().downloadTaskStream.listen((TaskInfo taskInfo) async {
      try {
        if (taskInfo == _taskInfo) {
          setState(() {
            _taskInfo.status = taskInfo.status;
            _taskInfo.progress = taskInfo.progress;
          });
        }
      } catch (e) {
        log('$e');
      }
    });
  }

  Future<void> setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    //UrlSource("${widget.songs.url}")
    await player.play(UrlSource("${widget.songs.url}"));
    setState(() {
      _isReady = true;
    });
  }

  @override
  void dispose() {
    player.dispose();
    _downloadStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xDD111100),
            Color(0xDD111100),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.6],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: LanguageString(
              language: widget.language!,
              englishText: widget.songs.title!,
              tamilText: widget.songs.titleTam,
              devanagariText: widget.songs.titleDev,
              kannadaText: widget.songs.titleKan,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
              maxLine: 2,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
            child: LanguageString(
              language: widget.language!,
              englishText: widget.songs.writer!,
              tamilText: widget.songs.writerTam,
              devanagariText: widget.songs.writerDev,
              kannadaText: widget.songs.writerKan,
              teluguText: widget.songs.writerTel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
              maxLine: 2,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            "${widget.vocals}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AbsorbPointer(
              absorbing: !_isReady,
              child: ProgressBar(
                timeLabelTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                progress: position,
                buffered: const Duration(milliseconds: 2000),
                total: duration,
                progressBarColor: Colors.red,
                baseBarColor: Colors.white.withOpacity(0.24),
                bufferedBarColor: Colors.white.withOpacity(0.24),
                thumbColor: Colors.white,
                barHeight: 3.0,
                thumbRadius: 5.0,
                onSeek: (duration) async {
                  await player.seek(duration);
                  await player.pause();
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkResponse(
            onTap: () async {
              if (isPlaying) {
                await player.pause();
              } else {
                await player.resume();
              }
            },
            child: Image.asset(
              isPlaying ? 'assets/images/pause.png' : 'assets/images/play.png',
              color: Colors.white,
              height: 60,
              width: 60,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: _taskInfo.status == DownloadTaskStatus.running ||
                        _taskInfo.status == DownloadTaskStatus.complete
                    ? null
                    : () {
                        DownloadService()
                            .downloadFile(_taskInfo, widget.songs.title!);
                      },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: _taskInfo.status == DownloadTaskStatus.running
                      ? SizedBox.square(
                          dimension: 40,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircularProgressIndicator(),
                              Text(
                                "${_taskInfo.progress} %",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : _taskInfo.status == DownloadTaskStatus.complete
                          ? GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: "Already Downloaded Song !!");
                              },
                              child: Builder(
                                builder: (context) {
                                  widget.songs.isDownland = true;
                                  return Image.asset(
                                    'assets/images/downloaded.png',
                                    width: 40.0,
                                    height: 30.0,
                                  );

                                }
                              ),
                            )
                          : Image.asset('assets/images/download.png',
                              width: 40.0, height: 30.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }
}
