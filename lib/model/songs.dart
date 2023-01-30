class Songs {
  final String? id;
  final String? title;
  final String? duration;
  final String? url;
  final String? writer;
  final String? lyrics;

  Songs({
    this.id,
    this.title,
    this.duration,
    this.url,
    this.writer,
    this.lyrics,
  });

  factory Songs.fromJson(Map<String, dynamic> json) {
    return Songs(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      url: json['url'],
      writer: json['writer'],
      lyrics: json['lyrics'],
    );
  }
}
