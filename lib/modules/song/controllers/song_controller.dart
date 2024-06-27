import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/modules/song/models/song_lyrics_model.dart';
import 'package:sangeet_api/modules/song/models/song_model.dart';

class SongController {
  final Dio _client;

  SongController({
    required Dio client,
  }) : _client = client;

  Future<SongModel?> getById({required String songId}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.songs.id,
        "pids": songId,
      });

      final resp = jsonDecode(res.data);
      if (res.statusCode != 200 || resp["status"] == "failure") {
        throw Error.throwWithStackTrace(resp["msg"], StackTrace.current);
      }

      final song = SongModel.fromMap(resp['songs'][0]);

      return song;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }

  Future<SongLyricsModel?> getLyricsById({required String lyricsId}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.songs.lyrics,
        "lyrics_id": lyricsId,
      });

      final resp = jsonDecode(res.data);
      if (res.statusCode != 200 || resp["status"] == "failure") {
        throw Error.throwWithStackTrace(
            resp['error']["msg"], StackTrace.current);
      }

      final lyrics = SongLyricsModel.fromMap(resp);

      return lyrics;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }
}
