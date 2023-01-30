import 'package:tungalahari/model/songs.dart';

class Album {
  final String? id;
  final String? title;
  final List<Songs>? totalSongs;

  Album({this.id, this.title, this.totalSongs});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      totalSongs: List<Songs>.from(json['songs'].map((x) => Songs.fromJson(x))),
    );
  }
}
