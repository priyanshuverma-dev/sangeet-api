import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/modules/song/models/song_lyrics_model.dart';
import 'package:sangeet_api/modules/song/models/song_model.dart';
import 'package:sangeet_api/modules/song/models/song_radio_model.dart';

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
        throw Error.throwWithStackTrace("Song Not found", StackTrace.current);
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
        throw Error.throwWithStackTrace('Lyrics not found', StackTrace.current);
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

  Future<String?> _createStation({required String songId}) async {
    try {
      final encodedSongId = jsonEncode([Uri.encodeComponent(songId)]);
      final res = await _client.get("/", queryParameters: {
        "ctx": "android",
        "__call": Endpoints.songs.station,
        "entity_id": encodedSongId,
        "entity_type": 'queue'
      });

      final resp = jsonDecode(res.data);
      if (resp["error"] != null) {
        throw Error.throwWithStackTrace(
          resp['error']['msg'],
          StackTrace.current,
        );
      }

      final String stationId = resp['stationid'];
      return stationId;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }

  Future<SongRadioModel?> radio({
    required String songId,
    int limit = 10,
  }) async {
    try {
      assert(limit >= 2, 'Limit should be greater than 2');
      String? stationId = await _createStation(songId: songId);

      final res = await _client.get("/", queryParameters: {
        "ctx": "android",
        "__call": Endpoints.songs.suggestions,
        "stationid": stationId,
        "k": limit
      });

      final resp = jsonDecode(res.data);
      if (resp["error"] != null) {
        throw Error.throwWithStackTrace(resp['error'], StackTrace.current);
      }

      final suggestions = Map<String, dynamic>.from(resp)..remove('stationid');

      final songs = suggestions.values
          .map((element) => SongModel.fromMap(element['song']))
          .take(limit)
          .toList();

      return SongRadioModel(
        total: songs.length,
        stationId: stationId,
        songs: songs,
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }
}
