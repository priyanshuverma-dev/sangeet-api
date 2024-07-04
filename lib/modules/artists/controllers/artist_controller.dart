import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/modules/album/models/album_model.dart';
import 'package:sangeet_api/modules/artists/models/artist_albums_model.dart';
import 'package:sangeet_api/modules/artists/models/artist_model.dart';
import 'package:sangeet_api/modules/artists/models/artist_songs_model.dart';
import 'package:sangeet_api/modules/song/models/song_model.dart';

class ArtistController {
  final Dio _client;

  ArtistController({
    required Dio client,
  }) : _client = client;

  /// Get artist by id
  /// ```dart
  /// final api = SangeetApi();
  /// final artist = await api.artist.getById(artistId: "123");
  /// ```
  /// Returns [ArtistModel] if found
  /// Returns [null] if not found

  Future<ArtistModel?> getById({required String artistId}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.artists.id,
        "artistId": artistId,
      });

      final resp = jsonDecode(res.data);
      if (res.statusCode != 200 || resp["status"] == "failure") {
        throw Error.throwWithStackTrace(
            resp['error']["msg"], StackTrace.current);
      }
      if (resp['name'] == '') {
        throw Error.throwWithStackTrace("Artist not found", StackTrace.current);
      }
      final artist = ArtistModel.fromMap(resp);
      return artist;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }

  /// Get artist songs
  /// ```dart
  /// final api = SangeetApi();
  /// final songs = await api.artist.getArtistSongs(artistId: "123");
  /// ```
  /// Returns [ArtistSongsModel] if found
  /// Returns [null] if not found

  Future<ArtistSongsModel?> getArtistSongs(
      {required String artistId, int page = 1, int limit = 10}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.artists.songs,
        "artistId": artistId,
        "page": page,
        "sort_order": "latest",
        "n": limit,
      });

      final resp = jsonDecode(res.data);
      if (res.statusCode != 200 || resp["status"] == "failure") {
        throw Error.throwWithStackTrace(
            resp['error']["msg"], StackTrace.current);
      }

      if (resp['name'] == null) {
        throw Error.throwWithStackTrace("Artist not found", StackTrace.current);
      }
      return ArtistSongsModel(
        total: resp['topSongs']['total'],
        songs: List<SongModel>.from(resp['topSongs']['songs'].map(
          (e) => SongModel.fromMap(e),
        )),
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }

  /// Get artist albums
  /// ```dart
  /// final api = SangeetApi();
  /// final albums = await api.artist.getArtistAlbums(artistId: "123");
  /// ```
  /// Returns [ArtistAlbumsModel] if found
  /// Returns [null] if not found

  Future<ArtistAlbumsModel?> getArtistAlbums(
      {required String artistId, int page = 1, int limit = 10}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.artists.albums,
        "artistId": artistId,
        "page": page,
        "sort_order": "latest",
        "n": limit,
      });

      final resp = jsonDecode(res.data);
      if (res.statusCode != 200 || resp["status"] == "failure") {
        throw Error.throwWithStackTrace(
            resp['error']["msg"], StackTrace.current);
      }

      if (resp['name'] == null) {
        throw Error.throwWithStackTrace("Albums not found", StackTrace.current);
      }

      return ArtistAlbumsModel(
        total: resp['topAlbums']['total'],
        albums: List<AlbumModel>.from(resp['topAlbums']['albums'].map(
          (e) => AlbumModel.fromMap(e),
        )),
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }
}
