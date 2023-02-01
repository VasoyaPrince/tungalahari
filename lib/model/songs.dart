class Songs {
  final String? id;
  final String? title;
  final String? duration;
  final String? url;
  final String? writer;
  final String? lyrics;
  final String? titleDev;
  final String? titleKan;
  final String? titleTam;
  final String? titleTel;
  final String? writerDev;
  final String? writerKan;
  final String? writerTam;
  final String? writerTel;
  final String? lyricsIast;
  final String? lyricsKan;
  final String? lyricsTam;
  final String? lyricsTel;

  Songs({
    this.id,
    this.title,
    this.duration,
    this.url,
    this.writer,
    this.lyrics,
    this.titleDev,
    this.titleKan,
    this.titleTam,
    this.titleTel,
    this.writerDev,
    this.writerKan,
    this.writerTam,
    this.writerTel,
    this.lyricsIast,
    this.lyricsKan,
    this.lyricsTam,
    this.lyricsTel,
  });

  factory Songs.fromJson(Map<String, dynamic> json) {
    return Songs(
      id: json['id'],
      title: json['title'],
      writer: json['writer'],
      duration: json['duration'],
      titleDev: json['title_dev'],
      titleKan: json['title_kan'],
      titleTam: json['title_tam'],
      titleTel: json['title_tel'],
      writerDev: json['writer_dev'],
      writerKan: json['writer_kan'],
      writerTam: json['writer_tam'],
      writerTel: json['writer_tel'],
      lyrics: json['lyrics'],
      lyricsIast: json['lyrics_iast'],
      lyricsKan: json['lyrics_kan'],
      lyricsTam: json['lyrics_tam'],
      lyricsTel: json['lyrics_tel'],
      //url: json['url'],
    );
  }
}
