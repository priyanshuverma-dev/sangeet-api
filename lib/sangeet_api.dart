library sangeet_api;

import 'package:dio/dio.dart';
import 'package:sangeet_api/common/constants.dart';
import 'package:sangeet_api/modules/album/controllers/album_controller.dart';
import 'package:sangeet_api/modules/artists/controllers/artist_controller.dart';
import 'package:sangeet_api/modules/explore/controllers/explore_controller.dart';
import 'package:sangeet_api/modules/playlist/controllers/playlist_controller.dart';
import 'package:sangeet_api/modules/search/controllers/search_controller.dart';
import 'package:sangeet_api/modules/song/controllers/song_controller.dart';

class SangeetAPI {
  /// Main Dio instance with required [BaseOptions]. Don't change anything unexpected.
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: Constants.serverUrl,
      queryParameters: Constants.defaultQueries,
    ),
  );

  /// explore has a set of functions to fetch trendings and initial or
  /// browse data like songs, albums, radios and more.
  ///
  /// Get trending songs.
  /// ```dart
  /// final api = SangeetAPI();
  /// BrowseTrendingModel? data = await api.explore.trending();
  ///
  /// ```
  /// More see [BrowseTrendingModel]
  ///
  /// Get browse data of this.
  ///
  /// ```dart
  /// final api = SangeetAPI();
  /// BrowseModel? data = await api.explore.browse();
  ///
  /// ```
  /// More see [BrowseModel]
  ///
  ExploreController get explore => ExploreController(client: _client);

  /// search has a set of functions to query songs, artists and more.
  ///
  /// Search Globally [SearchResultModel].
  /// ```dart
  /// final api = SangeetAPI();
  /// SearchResultModel? data = await api.search.global(query: "Dua Lipa");
  ///
  /// ```
  /// More see [SearchResultModel]
  ///
  /// Search Specific item. Songs [SearchResults]
  ///
  /// ```dart
  /// final api = SangeetAPI();
  /// BrowseModel? data = await api.search.songs(query: "Dua Lipa");
  ///
  /// ```
  /// More see [BrowseModel]
  ///
  SearchController get search => SearchController(client: _client);

  /// song has a set of functions to fetch songs by id, song lyrics,
  /// create radios from songs and more
  ///
  /// Get song by id.
  /// ```dart
  /// final api = SangeetAPI();
  /// SongModel? data = await api.song.getById(songId: "3IoDK8qI");
  ///
  /// ```
  /// More see [SongModel]
  ///
  /// Create Radio from song (recommended songs)
  ///
  /// ```dart
  /// final api = SangeetAPI();
  /// SongRadioModel? data = await api.song.radio(songId: "SongModel");
  ///
  /// ```
  /// More see [SongRadioModel]
  ///
  SongController get song => SongController(client: _client);

  /// artist has a set of functions to fetch artist details thier songs
  /// and albums
  ///
  /// Get Artist Details.
  /// ```dart
  /// final api = SangeetAPI();
  /// BrowseTrendingModel? data = await api.artist.getById(artistId: "1274170");
  ///
  /// ```
  /// More see [ArtistModel]
  ///
  /// Get artist albums.
  ///
  /// ```dart
  /// final api = SangeetAPI();
  /// BrowseModel? data = await api.artist.getArtistAlbums();
  ///
  /// ```
  /// More see [ArtistAlbumsModel]
  ///
  ArtistController get artist => ArtistController(client: _client);

  /// album has a set of functions to fetch album by id.
  ///
  /// Get album Details.
  ///
  /// ```dart
  /// final api = SangeetAPI();
  /// AlbumModel? data = await api.album.getById(artistId: "23241654");
  ///
  /// ```
  ///
  /// More see [AlbumModel]

  AlbumController get album => AlbumController(client: _client);

  /// playlist has a set of functions to fetch playlist by id.
  ///
  /// Get playlist details.
  ///
  /// ```dart
  /// final api = SangeetAPI();
  /// PlaylistModel? data = await api.playlist.getById(artistId: "1274170");
  ///
  /// ```
  /// More see [PlaylistModel]
  ///
  PlaylistController get playlist => PlaylistController(client: _client);
}
