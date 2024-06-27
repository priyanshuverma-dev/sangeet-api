import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
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

      final artist = ArtistModel.fromMap(resp);
      return artist;
    } catch (e, st) {
      if (kDebugMode) {
        print("ERROR: $e $st");
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

      return ArtistSongsModel(
        total: resp['topSongs']['total'],
        songs: List<SongModel>.from(resp['topSongs']['songs'].map(
          (e) => SongModel.fromMap(e),
        )),
      );
    } catch (e, st) {
      if (kDebugMode) {
        print("ERROR: $e \n $st");
      }
      return null;
    }
  }
}
