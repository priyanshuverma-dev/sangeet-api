import 'package:flutter_test/flutter_test.dart';

import 'package:sangeet_api/sangeet_api.dart';

void main() {
  final api = SangeetAPI();

  test("Song by ID", () async {
    final res = await api.song.getById(songId: "3IoDK8qI");
    expect('3IoDK8qI', res!.id);
  });

  test("Lyrics by Id", () async {
    final res = await api.song.getLyricsById(lyricsId: "ulCA5JTi");
    expect('Lyrics powered by www.musixmatch.com', res!.copyright);
  });
}
