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
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: Constants.serverUrl,
      queryParameters: Constants.defaultQueries,
    ),
  );

  ExploreController get explore => ExploreController(client: _client);
  SearchController get search => SearchController(client: _client);
  SongController get song => SongController(client: _client);
  ArtistController get artist => ArtistController(client: _client);
  AlbumController get album => AlbumController(client: _client);
  PlaylistController get playlist => PlaylistController(client: _client);
}
