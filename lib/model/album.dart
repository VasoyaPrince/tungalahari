import 'package:tungalahari/model/songs.dart';

class Album {
  final String? id;
  final String? title;
  final String? vocals;
  final String? director;
  final String? producer;
  final String? musicUri;
  final String? titleDev;
  final String? titleKan;
  final String? titleTam;
  final String? titleTel;
  final String? titleMal;
  final String? titleGuj;
  final List<Songs>? totalSongs;

  Album({
    this.id,
    this.title,
    this.totalSongs,
    this.vocals,
    this.director,
    this.producer,
    this.musicUri,
    this.titleDev,
    this.titleKan,
    this.titleTam,
    this.titleTel,
    this.titleMal,
    this.titleGuj,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      titleDev: json['title_dev'],
      titleKan: json['title_kan'],
      titleTam: json['title_tam'],
      titleTel: json['title_tel'],
      titleMal: json['title_mal'],
      titleGuj: json['title_guj'],
      vocals: json['vocals'],
      director: json['director'],
      producer: json['producer'],
      musicUri: json['musicUri'],
      totalSongs: List<Songs>.from(json['songs'].map((x) => Songs.fromJson(x))),
    );
  }
}
