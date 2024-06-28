// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'search_album_model.dart';
import 'search_artist_model.dart';
import 'search_playlist_model.dart';
import 'search_song_model.dart';

class SearchTopQueryModel {
  final List<SearchArtistModel> artists;
  final List<SearchSongModel> songs;
  final List<SearchAlbumModel> albums;
  final List<SearchPlaylistModel> playlists;
  final int position;

  SearchTopQueryModel({
    required this.albums,
    required this.artists,
    required this.playlists,
    required this.songs,
    required this.position,
  });

  factory SearchTopQueryModel.fromMap(Map<String, dynamic> map) {
    List<SearchArtistModel> artistsList = [];
    List<SearchSongModel> songsList = [];
    List<SearchAlbumModel> albumsList = [];
    List<SearchPlaylistModel> playlistsList = [];

    for (var item in map['data']) {
      switch (item['type']) {
        case 'artist':
          artistsList.add(SearchArtistModel.fromMap(item));
          break;
        case 'song':
          songsList.add(SearchSongModel.fromMap(item));
          break;
        case 'playlist':
          playlistsList.add(SearchPlaylistModel.fromMap(item));
          break;
        case 'album':
          albumsList.add(SearchAlbumModel.fromMap(item));
          break;
        default:
          throw Exception('Unknown type: ${item['type']}');
      }
    }
    return SearchTopQueryModel(
        albums: albumsList,
        artists: artistsList,
        playlists: playlistsList,
        songs: songsList,
        position: map['position']);
  }

  @override
  String toString() {
    return 'SearchTopQueryModel(artists: $artists, songs: $songs, albums: $albums, playlists: $playlists, position: $position)';
  }
}
