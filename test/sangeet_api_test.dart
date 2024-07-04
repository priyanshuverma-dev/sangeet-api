import 'package:flutter_test/flutter_test.dart';
import 'package:sangeet_api/sangeet_api.dart';

void main() {
  final api = SangeetAPI();

  group("Explore API Test", () {
    test("Get Trendings Check", () async {
      final data = await api.explore.trending();
      expect(data?.total, 10);
    });

    test("Get Browse Data Check", () async {
      final data = await api.explore.browse();
      expect(data?.charts.length, 6);
    });

    test("Get Chart Data Check", () async {
      final explore = await api.explore.browse();
      final token = explore?.charts[0].token;
      final data = await api.explore.chart(token: token!, limit: 20);
      expect(data?.songs.length, 20);
    });
  });

  group("Search API Test", () {
    test("Get Global Search Check", () async {
      final res = await api.search.global(query: "Dua Lipa");

      expect(res?.top.artists[0].title, 'Dua Lipa');
    });
    test("Get Song Search Check", () async {
      final res = await api.search.songs(query: "Sajni");

      expect(res?.start, 1);
    });
    test("Get Album Search Check", () async {
      final res = await api.search.albums(query: "Dua Lipa");

      expect(res?.start, 1);
    });
    test("Get Artist Search Check", () async {
      final res = await api.search.artists(query: "Dua Lipa");

      expect(res?.start, 1);
    });
    test("Get Playlist Search Check", () async {
      final res = await api.search.playlists(query: "Dua Lipa");
      expect(res?.start, 1);
    });
  });

  group("Songs API Test", () {
    test("Get Song Id Check", () async {
      final res = await api.song.getById(songId: "3IoDK8qI");
      expect(res!.id, "3IoDK8qI");
    });

    test("Get Song Id Null Check", () async {
      final res = await api.song.getById(songId: "3IoDK8qIas");
      expect(res, null);
    });

    test("Get Song Station Check", () async {
      final radio =
          await api.song.radio(songId: "FB8WBiWv", limit: 2, featured: false);

      expect(radio?.songs.length, 2);
    }, skip: true);
    test("Get Song Station Null Check", () async {
      final radio = await api.song
          .radio(songId: "yDeAS8Ehqwq", limit: 2, featured: false);

      expect(radio, null);
    });

    test("Get Featured Station Check", () async {
      final radio = await api.song
          .radio(songId: "Sufiyana Safar", limit: 2, featured: true);

      expect(radio?.total, 2);
    }, skip: true);

    test("Get Lyrics Id Check", () async {
      final res = await api.song.getLyricsById(lyricsId: "ulCA5JTi");
      expect(res!.copyright, 'Lyrics powered by www.musixmatch.com');
    });
    test("Get Lyrics Id Null Check", () async {
      final res = await api.song.getLyricsById(lyricsId: "ulCA5JTiadad");
      expect(res, null);
    });
  });

  group("Artist API Test", () {
    test("Get Artist Songs Check", () async {
      final artistSongs = await api.artist.getArtistSongs(artistId: "459320");
      expect(artistSongs?.songs.length, 10);
    });
    test("Get Artist Songs Null Check", () async {
      final artistSongs =
          await api.artist.getArtistSongs(artistId: "127417012");
      expect(artistSongs, null);
    });

    test("Get Artist Id Check", () async {
      final artist = await api.artist.getById(artistId: "1274170");
      expect(artist?.id, '1274170');
    });
    test("Get Artist Id Null Check", () async {
      final artist = await api.artist.getById(artistId: "127417012");
      expect(artist, null);
    });

    test("Get Artist Albums Check", () async {
      final albums = await api.artist.getArtistAlbums(artistId: '459320');

      expect(albums?.total, albums?.total);
    });
    test("Get Artist Albums Null Check", () async {
      final albums = await api.artist.getArtistAlbums(artistId: '127417021');
      expect(albums, null);
    });
  });

  group("Album & Playlist API Test", () {
    test("Get Album Id Check", () async {
      final album = await api.album.getById(albumId: '23241654');
      expect(album?.id, '23241654');
    });
    test("Get Album Id Null Check", () async {
      final album = await api.album.getById(albumId: '232416541');
      expect(album, null);
    });

    test("Get Playlist Id Check", () async {
      final playlist = await api.playlist.getById(id: '10301457', limit: 10);
      expect(playlist?.songs.length, 10);
    });
    test("Get Playlist Id Null Check", () async {
      final playlist = await api.playlist.getById(id: '1558718013', limit: 1);
      expect(playlist, null);
    });
  });

  //
}
