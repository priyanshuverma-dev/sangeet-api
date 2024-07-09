import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sangeet_api/common/endpoints.dart';
import 'package:sangeet_api/common/utils.dart';
import 'package:sangeet_api/models.dart';

class SongController {
  final Dio _client;
  final String? _defaultDownloadPath;

  SongController({
    required Dio client,
    String? defaultDownloadPath,
  })  : _client = client,
        _defaultDownloadPath = defaultDownloadPath;

  /// Get song by id
  ///
  /// required [songId] should be a valid song id
  ///
  /// ```dart
  /// final api = SangeetApi();
  /// final song = await api.song.getById(songId: "123");
  /// ```
  /// Returns [SongModel] if found
  ///
  /// Returns [null] if not found

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

  /// Get song lyrics by id
  ///
  /// required [lyricsId] should be a valid lyrics id
  ///
  /// ```dart
  /// final api = SangeetApi();
  /// final lyrics = await api.song.getLyricsById(lyricsId: "
  /// ```
  /// Returns [SongLyricsModel] if found
  ///
  /// Returns [null] if not found

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

  Future<String?> _createFeaturesStation(
      {required String name, required String language}) async {
    try {
      final res = await _client.get("/", queryParameters: {
        "language": language,
        "ctx": "wap6dot0",
        "__call": Endpoints.songs.featured,
        "name": name,
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

  /// Get song radio
  ///
  /// required [songId] should be a valid song id
  ///
  /// optional [featured] if true will create a featured station
  ///
  /// optional [limit] number of songs to return
  ///
  /// ```dart
  /// final api = SangeetApi();
  /// final radio = await api.song.radio(songId: "123", limit: 10);
  ///
  /// ```
  ///
  /// Returns [SongRadioModel] if found
  ///
  /// Returns [null] if not found

  Future<SongRadioModel?> radio({
    bool featured = false,
    required String songId,
    int limit = 20,
    String language = "hindi",
  }) async {
    try {
      assert(limit >= 2, 'Limit should be greater than 2');

      String? stationId;
      if (featured) {
        stationId =
            await _createFeaturesStation(name: songId, language: language);
      } else {
        stationId = await _createStation(songId: songId);
      }

      final res = await _client.get("/", queryParameters: {
        "stationid": stationId,
        "ctx": "android",
        "__call": Endpoints.songs.suggestions,
        "k": limit
      });

      final resp = jsonDecode(res.data);

      if (res.data == "[]" || resp['error'] != null) {
        throw Error.throwWithStackTrace(
            resp['error'] ?? "Can't fetch radio", StackTrace.current);
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

  Future<DownloadRes> downloadById({
    required String songId,
    SongQuality quality = SongQuality.v160kbps,
    String folder = 'songs',
  }) async {
    try {
      final song = await getById(songId: songId);
      if (song == null) {
        return DownloadRes(success: false, failureMessage: "Song Not found");
      }

      final downloadUrl = song.urls
          .where((element) => element.quality == quality.name)
          .toList()[0]
          .url;

      final savePathPrefix =
          _defaultDownloadPath ?? Utils.defaultDownloadPath();
      final savePath =
          "$savePathPrefix/$folder/${song.title} ${quality.name.replaceFirst('v', "")}.mp4";

      if (Directory(savePath).existsSync()) {
        return DownloadRes(success: true);
      }
      final res = await _client.downloadUri(
        Uri.parse(downloadUrl),
        savePath,
        options: Options(
          validateStatus: (status) => status == 200,
        ),
      );

      if (res.statusCode != 200) {
        return DownloadRes(
          success: false,
          failureMessage: "Unable to download song",
        );
      }

      return DownloadRes(
        success: true,
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return DownloadRes(success: false, failureMessage: e.toString());
    }
  }

  Future<DownloadRes> downloadImageById({
    required String songId,
    ImageQuality quality = ImageQuality.medium,
    String folder = 'images',
  }) async {
    try {
      final song = await getById(songId: songId);
      if (song == null) {
        return DownloadRes(success: false, failureMessage: "Song Not found");
      }

      final downloadUrl = song.images
          .where((element) => element.quality == quality.quality)
          .toList()[0]
          .url;

      final savePathPrefix =
          _defaultDownloadPath ?? Utils.defaultDownloadPath();
      final savePath = "$savePathPrefix/$folder/${song.id}.png";

      if (Directory(savePath).existsSync()) {
        return DownloadRes(success: true);
      }
      final res = await _client.downloadUri(
        Uri.parse(downloadUrl),
        savePath,
        options: Options(
          validateStatus: (status) => status == 200,
        ),
      );

      if (res.statusCode != 200) {
        return DownloadRes(
          success: false,
          failureMessage: "Unable to download image",
        );
      }

      return DownloadRes(
        success: true,
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return DownloadRes(success: false, failureMessage: e.toString());
    }
  }

  Future<DownloadRes> downloadByURL({
    required String url,
    String folder = 'others',
    required String fileName,
  }) async {
    try {
      final savePathPrefix =
          _defaultDownloadPath ?? Utils.defaultDownloadPath();
      final savePath = "$savePathPrefix/$folder/$fileName";

      if (Directory(savePath).existsSync()) {
        return DownloadRes(success: true);
      }
      final res = await _client.downloadUri(
        Uri.parse(url),
        savePath,
        options: Options(
          validateStatus: (status) => status == 200,
        ),
      );

      if (res.statusCode != 200) {
        return DownloadRes(
          success: false,
          failureMessage: "Unable to download image",
        );
      }

      return DownloadRes(
        success: true,
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return DownloadRes(success: false, failureMessage: e.toString());
    }
  }
}
