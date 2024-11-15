import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/modules/playlist/models/playlist_model.dart';

class PlaylistController {
  final Dio _client;

  PlaylistController({
    required Dio client,
  }) : _client = client;

  /// Get playlist by id
  ///
  /// required [id] should be a valid playlist id
  ///
  /// optional [page] and [limit] for pagination
  ///
  /// ```dart
  /// final api = SangeetApi();
  /// final playlist = await api.playlist.getById(id: "123");
  /// ```
  /// Returns [PlaylistModel] if found
  /// Returns [null] if not found

  Future<PlaylistModel?> getById({
    required String id,
    int page = 0,
    int limit = 10,
  }) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.playlists.id,
        "listid": id,
        'n': limit,
        'p': page
      });

      final resp = jsonDecode(res.data);
      if (res.statusCode != 200 || resp["status"] == "failure") {
        throw Error.throwWithStackTrace(
            resp['error']["msg"], StackTrace.current);
      }

      if (resp["title"] == '') {
        throw Error.throwWithStackTrace("Playlist not found", StackTrace.empty);
      }

      final playlist = PlaylistModel.fromMap(resp);
      return playlist;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }
}
