import 'package:tungalahari/model/songs.dart';

class Album {
  final String? image;
  final String? title;
  final List<Songs>? totalSongs;

  Album({this.image, this.title, this.totalSongs});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      image: json['Image'],
      title: json['Title'],
      totalSongs: List<Songs>.from(json['Songs'].map((x) => Songs.fromJson(x))),
    );
  }
}
