import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/modules/album/models/album_model.dart';

class AlbumController {
  final Dio _client;

  AlbumController({
    required Dio client,
  }) : _client = client;

  /// Get album by id
  /// ```dart
  /// final album = await AlbumController().getById(albumId: "123");
  /// ```
  ///
  /// Returns [AlbumModel] if found
  /// Returns [null] if not found
  ///
  Future<AlbumModel?> getById({required String albumId}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "ctx": "web6dot0",
        "__call": Endpoints.albums.id,
        "albumid": albumId,
      });

      final resp = jsonDecode(res.data);
      if (res.statusCode != 200 || resp["status"] == "failure") {
        throw Error.throwWithStackTrace(
            resp['error']["msg"], StackTrace.current);
      }
      if (resp['id'] == "") {
        throw Error.throwWithStackTrace("Album not found", StackTrace.current);
      }

      final album = AlbumModel.fromMap(resp);
      return album;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return null;
    }
  }
}
