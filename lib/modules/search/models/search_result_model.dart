// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sangeet_api/modules/search/models/search_album_model.dart';
import 'package:sangeet_api/modules/search/models/search_artist_model.dart';
import 'package:sangeet_api/modules/search/models/search_playlist_model.dart';
import 'package:sangeet_api/modules/search/models/search_song_model.dart';
import 'package:sangeet_api/modules/search/models/search_topquery_model.dart';

class Results<T> {
  final List<T> results;
  final int position;

  Results({
    required this.results,
    required this.position,
  });
}

class SearchResults<T> {
  final List<T> results;
  final int start;
  final int total;

  SearchResults({
    required this.results,
    required this.start,
    required this.total,
  });
}

class SearchResultModel {
  final SearchTopQueryModel top;
  final Results<SearchAlbumModel> albums;
  final Results<SearchSongModel> songs;
  final Results<SearchArtistModel> artists;
  final Results<SearchPlaylistModel> playlists;
  SearchResultModel({
    required this.top,
    required this.albums,
    required this.songs,
    required this.artists,
    required this.playlists,
  });

  factory SearchResultModel.fromMap(Map<String, dynamic> map) {
    return SearchResultModel(
      top: SearchTopQueryModel.fromMap(map['topquery']),
      albums: Results(
        results: List<SearchAlbumModel>.from(
          map['albums']['data'].map<SearchAlbumModel>(
            (e) => SearchAlbumModel.fromMap(e),
          ),
        ),
        position: map['albums']['position'],
      ),
      songs: Results(
        results: List<SearchSongModel>.from(
          map['songs']['data'].map<SearchSongModel>(
            (e) => SearchSongModel.fromMap(e),
          ),
        ),
        position: map['songs']['position'],
      ),
      artists: Results(
        results: List<SearchArtistModel>.from(
          map['artists']['data'].map<SearchArtistModel>(
            (e) => SearchArtistModel.fromMap(e),
          ),
        ),
        position: map['artists']['position'],
      ),
      playlists: Results(
        results: List<SearchPlaylistModel>.from(
          map['playlists']['data'].map<SearchPlaylistModel>(
            (e) => SearchPlaylistModel.fromMap(e),
          ),
        ),
        position: map['playlists']['position'],
      ),
    );
  }

  @override
  String toString() {
    return 'SearchResultModel(top: $top, albums: $albums, songs: $songs, artists: $artists, playlists: $playlists)';
  }
}
