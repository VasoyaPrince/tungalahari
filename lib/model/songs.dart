class Songs {
  final String? name;
  final String? subtitle;
  final String? duration;
  final String? url;
  final String? singerName;
  final String? songLayers;

  Songs({this.name, this.subtitle, this.duration, this.url, this.singerName,this.songLayers});

  factory Songs.fromJson(Map<String, dynamic> json) {
    return Songs(
      name: json['Name'],
      subtitle: json['subtitle'],
      duration: json['duration'],
      url: json['url'],
      singerName: json['singerName'],
      songLayers: json['songLayers'],
    );
  }
}
