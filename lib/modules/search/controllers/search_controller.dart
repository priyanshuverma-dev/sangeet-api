import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/modules/album/models/album_model.dart';
import 'package:sangeet_api/modules/artists/models/artist_map_model.dart';
import 'package:sangeet_api/modules/playlist/models/playlist_map_model.dart';
import 'package:sangeet_api/modules/search/models/search_result_model.dart';
import 'package:sangeet_api/modules/song/models/song_model.dart';

class SearchController {
  final Dio _client;

  SearchController({
    required Dio client,
  }) : _client = client;

  Future<SearchResultModel?> global({required String query}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.search.all,
        "query": query.replaceAll(' ', '+'),
      });

      final resp = jsonDecode(res.data);

      if (resp == []) {
        throw Error.throwWithStackTrace(
            "No results found for $query", StackTrace.current);
      }

      final results = SearchResultModel.fromMap(resp);
      return results;
    } catch (e) {
      if (kDebugMode) {
        print("GLOBAL SEARCH ERROR: $e");
      }
      return null;
    }
  }

  Future<SearchResults?> songs({
    required String query,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.search.songs,
        "q": query.replaceAll(' ', '+'),
        "p": page,
        "n": limit
      });

      final resp = jsonDecode(res.data);

      if (resp['results'] == []) {
        throw Error.throwWithStackTrace(
            "No results found for $query", StackTrace.current);
      }

      final songs = resp['results'].map((element) {
        return SongModel.fromMap(element);
      });

      return SearchResults<SongModel>(
        results: List<SongModel>.from(songs),
        start: resp['start'],
        total: resp['total'],
      );
    } catch (e) {
      if (kDebugMode) {
        print("SONGS SEARCH ERROR: $e");
      }
      return null;
    }
  }

  Future<SearchResults?> albums({
    required String query,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.search.albums,
        "q": query.replaceAll(' ', '+'),
        "p": page,
        "n": limit
      });

      final resp = jsonDecode(res.data);

      if (resp['results'] == []) {
        throw Error.throwWithStackTrace(
            "No results found for $query", StackTrace.current);
      }

      final albums = resp['results'].map((element) {
        return AlbumModel.fromMap(element);
      });

      return SearchResults<AlbumModel>(
        results: List<AlbumModel>.from(albums),
        start: resp['start'],
        total: resp['total'],
      );
    } catch (e) {
      if (kDebugMode) {
        print("ALBUMS SEARCH ERROR: $e");
      }
      return null;
    }
  }

  Future<SearchResults?> artists({
    required String query,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.search.artists,
        "q": query.replaceAll(' ', '+'),
        "p": page,
        "n": limit
      });

      final resp = jsonDecode(res.data);

      if (resp['results'] == []) {
        throw Error.throwWithStackTrace(
            "No results found for $query", StackTrace.current);
      }

      final artists = resp['results'].map((element) {
        return ArtistMapModel.fromMap(element);
      });

      return SearchResults<ArtistMapModel>(
        results: List<ArtistMapModel>.from(artists),
        start: resp['start'],
        total: resp['total'],
      );
    } catch (e) {
      if (kDebugMode) {
        print("ARTISTS SEARCH ERROR: $e");
      }
      return null;
    }
  }

  Future<SearchResults?> playlists({
    required String query,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.search.playlists,
        "q": query.replaceAll(' ', '+'),
        "p": page,
        "n": limit
      });

      final resp = jsonDecode(res.data);

      if (resp['results'] == []) {
        throw Error.throwWithStackTrace(
            "No results found for $query", StackTrace.current);
      }

      final playlists = resp['results'].map((element) {
        return PlaylistMapModel.fromMap(element);
      });

      return SearchResults<PlaylistMapModel>(
        results: List<PlaylistMapModel>.from(playlists),
        start: resp['start'],
        total: resp['total'],
      );
    } catch (e) {
      if (kDebugMode) {
        print("GLOBAL SEARCH ERROR: $e");
      }
      return null;
    }
  }
}
