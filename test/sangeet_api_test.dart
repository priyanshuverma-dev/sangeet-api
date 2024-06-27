import 'package:flutter_test/flutter_test.dart';
import 'package:sangeet_api/sangeet_api.dart';

void main() {
  final api = SangeetAPI();

  test("Playlist by Id", () async {
    final playlist = await api.playlist.getById(id: '155871808', limit: 1);
    expect('155871808', playlist?.id);
  });
  test("Album by Id", () async {
    final album = await api.album.getById(albumId: '23241654');
    expect('23241654', album?.id);
  });

  test("Artist Songs", () async {
    final artistSongs = await api.artist.getArtistSongs(artistId: "1274170");
    expect(1265, artistSongs?.total);
  });

  test("Artist by Id", () async {
    final artist = await api.artist.getById(artistId: "1274170");
    expect('1274170', artist?.id);
  });

  test("Song by Id", () async {
    final res = await api.song.getById(songId: "3IoDK8qI");
    expect('3IoDK8qI', res!.id);
  });

  test("Lyrics by Id", () async {
    final res = await api.song.getLyricsById(lyricsId: "ulCA5JTi");
    expect('Lyrics powered by www.musixmatch.com', res!.copyright);
  });
}
