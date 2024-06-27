class SongLyricsModel {
  final String lyrics;
  final String copyright;
  final String snippet;

  SongLyricsModel({
    required this.lyrics,
    required this.copyright,
    required this.snippet,
  });

  factory SongLyricsModel.fromMap(Map<String, dynamic> map) {
    return SongLyricsModel(
      lyrics: map['lyrics'],
      copyright: map['lyrics_copyright'],
      snippet: map['snippet'],
    );
  }
}
