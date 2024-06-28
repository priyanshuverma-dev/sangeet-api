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

  Future<ArtistSongsModel?> getArtistSongs(
      {required String artistId, int page = 0}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.artists.songs,
        "artistId": artistId,
        "page": page,
        "sort_order": "latest"
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

  Future<ArtistAlbumsModel?> getArtistAlbums(
      {required String artistId, int page = 0}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.artists.albums,
        "artistId": artistId,
        "page": page,
        "sort_order": "latest"
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
